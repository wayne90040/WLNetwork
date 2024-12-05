import Foundation

public class Session {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    private func crtReq<T: Request>(_ request: T) throws -> URLRequest{
        let url = request.baseURL
            .appendingPathComponentIfNotEmpty(request)

        var urlReq = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeout)

        try request.adapters.forEach { try $0.adapted(&urlReq) }

        return urlReq
    }
}

public extension Session {

    func send<T: Request>(_ request: T, completion: @escaping(Result<T.Response, Error>) -> Void) {
        let urlReq: URLRequest

        do {
            urlReq = try crtReq(request)
        }
        catch {
            completion(.failure(error))
            return
        }

        let task = session.dataTask(with: urlReq) { [weak self] data, response, error in
            guard
                let self,
                let data = data,
                let response = response as? HTTPURLResponse
            else {
                completion(.failure(WLNetworkError.sendFailed(.missingResponse)))
                return
            }
            self.handleDecision(request, data: data, response: response, decisions: request.decisions, completion: completion)
        }
        task.resume()
    }

    private func handleDecision<T: Request>(
        _ request: T,
        data: Data,
        response: HTTPURLResponse,
        decisions: [Decision],
        completion: @escaping(Result<T.Response, Error>) -> Void
    ) {
        guard !decisions.isEmpty else {
            return
        }

        var decisions = decisions
        let current = decisions.removeFirst()

        guard current.shouldApply(request, data: data, response: response) else {
            handleDecision(request, data: data, response: response, decisions: decisions, completion: completion)
            return
        }
        current.apply(request, data: data, response: response) { [weak self] in
            guard let self = self else {
                return
            }

            switch $0 {
            case .continueWith(let data, let response):
                self.handleDecision(request, data: data, response: response, decisions: decisions, completion: completion)

            case .retryWith(_):
                self.send(request, completion: completion)

            case .stop(let err):
                completion(.failure(err))

            case .done(let resp):
                completion(.success(resp))
            }
        }
    }
}

@available(iOS 13.0.0, *)
public extension Session {

    func send<T: Request>(_ request: T) async -> Result<T.Response, Error> {
        let urlReq: URLRequest

        do {
            urlReq = try crtReq(request)
            let (data, resp) = try await session.data(for: urlReq)

            guard let resp = resp as? HTTPURLResponse else {
                return .failure(WLNetworkError.sendFailed(.missingResponse))
            }

            return await handleDecision(request, data: data, response: resp, decisions: request.decisions)
        }
        catch {
            return .failure(WLNetworkError.sendFailed(.failed(error)))
        }
    }

    private func handleDecision<T: Request>(
        _ request: T,
        data: Data,
        response: HTTPURLResponse,
        decisions: [Decision]
    ) async -> Result<T.Response, Error> {
        guard !decisions.isEmpty else {
            return .failure(WLNetworkError.decisionFailed(.emptyDecision))
        }
        
        var decisions = decisions
        let current = decisions.removeFirst()

        guard current.shouldApply(request, data: data, response: response) else {
            return await handleDecision(request, data: data, response: response, decisions: decisions)
        }

        let action = await current.apply(request, data: data, response: response)

        switch action {
        case .continueWith(let data, let response):
            return await handleDecision(request, data: data, response: response, decisions: decisions)

        case .retryWith(_):
            return await send(request)

        case .stop(let err):
            return .failure(WLNetworkError.decisionFailed(.stop(err)))

        case .done(let resp):
            return .success(resp)
        }
    }
}
