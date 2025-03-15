import Foundation

public struct HeadDecodeDecision: Decision {
    public init() { }
    
    enum HeadDecodeError: Error {
        case headDecodeFailed
        case keyDecodeFailed
    }

    public func shouldApply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) -> Bool {
        true
    }
    
    public func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping (DecisionAction<T>) -> Void) {
        var headers: [String: Any] = [:]
        
        for (key, value) in response.allHeaderFields {
            if let key = key as? String {
                headers[key] = value
            }
            else {
                completion(.stop(WLNetworkError.decodeFailed(HeadDecodeError.keyDecodeFailed)))
                return
            }
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: headers, options: [.prettyPrinted])
            let value = try JSONDecoder().decode(T.Response.self, from: data)
            completion(.done(value))
        }
        catch {
            completion(.stop(WLNetworkError.decodeFailed(error)))
        }
    }
    
    @available(iOS 13.0.0, *)
    public func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T> {
        var headers: [String: String] = [:]
        
        for (key, value) in response.allHeaderFields {
            if let key = key as? String {
                var value = value as? String ?? ""
                headers[key.lowercased()] = value as? String ?? ""
            }
            else {
                return .stop(WLNetworkError.decodeFailed(HeadDecodeError.keyDecodeFailed))
            }
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: headers, options: [.prettyPrinted])
            let value = try JSONDecoder().decode(T.Response.self, from: jsonData)
            return .done(value)
        }
        catch {
            return .stop(WLNetworkError.decodeFailed(error))
        }
    }
}
