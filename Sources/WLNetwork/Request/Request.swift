import Foundation

public typealias Parameters = [String: Any?]

public protocol Request {
    
    /// Binding response model
    associatedtype Response: Decodable

    var method: HttpMethod { get }
    
    var baseURL: URL { get }
    
    var contentType: ContentType { get }
    
    var path: String { get }
    
    /// only for `Get` method
//    var queries: [URLQueryItem]? { get } 
    
    /// except `Get` methods
    var parameters: Parameters? { get }
    
    var timeout: TimeInterval { get }

    /// To modify current request `properties`
    /// Default `defaultAdapter` + `specificAdapter`
    var adapters: [RequestAdapter] { get }

    /// `adapter` for all request
    var defaultAdapter: [RequestAdapter] { get }

    /// `adapter` for specific request
    var specifiAdapter: [RequestAdapter] { get }
    
    var decisions: [Decision] { get }

    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension Request {
    var queries: [URLQueryItem]? {
        nil
    }

    var parameters: Parameters? {
        nil
    }

    var adapters: [RequestAdapter] {
        defaultAdapter + specifiAdapter
    }
    
    var defaultAdapter: [RequestAdapter] {
        var adapters: [RequestAdapter] = [
            method.adapter
        ]
        
        contentType.adapter.map {
            adapters.append($0)
        }

        if let parameters = parameters {
            switch (method, contentType) {
            case (.Get, _):
                adapters.append(URLQueryAdapter(parameters: parameters))

            case (_, .formUrlEncoded):
                // TODO: Need to do implement
                break
            case (_, .json):
                adapters.append(JsonParameterAdapter(parameters: parameters))

            case (_, .none):
                break
            }
        }
        
        return adapters
    }
    
    var specifiAdapter: [RequestAdapter] {
        []
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        .reloadIgnoringLocalAndRemoteCacheData
    }
    
    var timeout: TimeInterval {
        30
    }
}
