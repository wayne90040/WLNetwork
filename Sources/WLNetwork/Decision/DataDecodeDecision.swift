import Foundation

public struct DataDecodeDecision: Decision {
    public init() { }
    
    enum DataDecodeError: Error {
        case dataDecodeFailed
    }
    
    public func shouldApply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) -> Bool {
        true
    }
    
    public func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping (DecisionAction<T>) -> Void) {
        guard let data = data as? T.Response else {
            completion(.stop(WLNetworkError.decodeFailed(DataDecodeError.dataDecodeFailed)))
            return
        }
        completion(.done(data))
    }
    
    @available(iOS 13.0.0, *)
    public func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T> {
        guard let data = data as? T.Response else {
            return .stop(WLNetworkError.decodeFailed(DataDecodeError.dataDecodeFailed))
        }
        return .done(data)
    }
}
