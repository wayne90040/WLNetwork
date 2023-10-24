import Foundation

public class Session {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func send<T: Request>(_ request: T, completion: @escaping(Result<T.Response, Error>) -> Void) {
        let urlRequest: URLRequest

        do {
            urlRequest = try create(request)
        }
        catch {
            completion(.failure(error))
            return
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse
            else {
//                completion(.failure(Error()))
                return
            }
            self.handleDecision(request, data: data, response: response, decisions: request.decisions, completion: completion)
        }
        task.resume()
    }

    private func create<T: Request>(_ request: T) throws -> URLRequest{
        let url = request.baseURL
            .appendingPathComponentIfNotEmpty(request)
            .appendingQueryItems(request)

        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeout)

        request.adapters.forEach {
            do {
                try $0.adapted(&urlRequest)
            }
            catch {
                debugPrint("Create URLquest Error: \(error)")
            }
        }
        return urlRequest
    }

    private func handleDecision<T: Request>(
        _ request: T,
        data: Data,
        response: HTTPURLResponse,
        decisions: [Decision],
        completion: @escaping(Result<T.Response, Error>) -> Void
    ) {
        guard !decisions.isEmpty else {
            debugPrint("Request Decisions is empty")
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

            case .stop(let error):
                completion(.failure(error))

            case .done(let response):
                completion(.success(response))
            }
        }
    }
}
