import Foundation

public struct URLQueryAdapter: RequestAdapter {
    public var parameters: Encodable

    public init(parameters: Encodable) {
        self.parameters = parameters
    }
    
    public func adapted(_ request: inout URLRequest) throws {
        guard let url = request.url else {
            throw WLNetworkError.urlIsNil
        }
        
        let query = try QueryParamEncoder().encode(parameters)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw WLNetworkError.urlComponentIsNil
        }
        
        components.query = query
        request.url = components.url
    }
}
