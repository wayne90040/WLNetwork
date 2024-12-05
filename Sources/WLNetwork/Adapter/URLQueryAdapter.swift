import Foundation

public struct URLQueryAdapter: RequestAdapter, Parameterable {

    public var parameters: Parameters

    public init(parameters: Parameters) {
        self.parameters = parameters
    }
    
    public func adapted(_ request: inout URLRequest) throws {
        guard let url = request.url else {
            throw WLNetworkError.crtReqFailed(.missingURL)
        }
        
        let queries = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw WLNetworkError.crtReqFailed(.URLComponentNil)
        }
        
        components.queryItems = queries
        request.url = components.url
    }
}
