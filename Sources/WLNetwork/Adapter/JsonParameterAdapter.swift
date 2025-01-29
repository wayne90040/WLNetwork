import Foundation

public struct JsonParameterAdapter: RequestAdapter {
    public var parameters: Encodable

    public init(parameters: Encodable) {
        self.parameters = parameters
    }
    
    public func adapted(_ request: inout URLRequest) throws {
        do {
            let body = try JSONEncoder().encode(parameters)
            request.httpBody = body
        }
        catch {
            throw WLNetworkError.crtReqFailed(.jsonEncodeFailed(error))
        }
    }
}
