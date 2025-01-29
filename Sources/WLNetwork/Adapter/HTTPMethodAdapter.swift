import Foundation

public struct HTTPMethodAdapter: RequestAdapter {
    public var method: HttpMethod
    
    public init(method: HttpMethod) {
        self.method = method
    }
    
    public func adapted(_ request: inout URLRequest) throws {
        request.httpMethod = method.rawValue
    }
}
