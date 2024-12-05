import Foundation

public protocol Decision {
    
    func shouldApply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse) -> Bool
    
    func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping(DecisionAction<T>) -> Void)

    @available(iOS 13.0.0, *)
    func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T>
}

extension Decision {
    public func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping(DecisionAction<T>) -> Void) {
    }

    @available(iOS 13.0.0, *)
    public func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse) async -> DecisionAction<T> {
        .continueWith(data, response)
    }
}

public enum DecisionAction<T: Request> {
    
    /// Continue the handle process with data & response
    case continueWith(Data, HTTPURLResponse)
    
    /// Retry request with `Decision`
    case retryWith([Decision])
    
    /// Stop when error
    case stop(Error)
    
    case done(T.Response)
}
