import Foundation

public struct JsonDecodeDecision: Decision {
    
    public init() { }
    
    public func shouldApply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse) -> Bool {
        true
    }
    
    public func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping (DecisionAction<T>) -> Void) {
        do {
            let value = try JSONDecoder().decode(T.Response.self, from: data)
            completion(.done(value))
        }
        catch { 
            completion(.stop(WLNetworkError.decisionFailed(.stop(error))))
        }
    }
    
    @available(iOS 13.0.0, *)
    public func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T> {
        do {
            let value = try JSONDecoder().decode(T.Response.self, from: data)
            return .done(value)
        }
        catch {
            return .stop(WLNetworkError.decisionFailed(.stop(error)))
        }
    }
}
