import Foundation

public protocol Decision {
    
    func shouldApply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) -> Bool
    
    func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping(DecisionAction<T>) -> Void)

    @available(iOS 13.0.0, *)
    func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T>
}

extension Decision {
    public func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping(DecisionAction<T>) -> Void) {
    }

    @available(iOS 13.0.0, *)
    public func apply<T: WLRequest>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T> {
        .continueWith(data, response)
    }
}

public enum DecisionAction<T: WLRequest> {
    
    /// Continue the handle process with data & response
    case continueWith(Data, HTTPURLResponse)
    
    /// Retry request with `Decision`
    case retryWith([Decision])
    
    /// Stop when error
    case stop(Error)
    
    case done(T.Response)
}
