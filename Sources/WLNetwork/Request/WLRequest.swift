import Foundation

public protocol WLRequest {
    associatedtype Response: Decodable
    associatedtype Parameters: Encodable

    var baseURL: URL { get }
    var method: HttpMethod { get }
    var path: String { get }
    var contentType: ContentType { get }
    
    /// Must to be `optional` type
    var parameters: Parameters? { get }
    
    var timeout: TimeInterval { get }

    /// To modify current request `properties`
    var adapters: [RequestAdapter] { get }
    
    var decisions: [Decision] { get }

    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension WLRequest {
    
    var parameters: Parameters? {
        nil
    }

    var adapters: [RequestAdapter] {
        []
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        .reloadIgnoringLocalAndRemoteCacheData
    }
    
    var timeout: TimeInterval {
        30
    }
}
