import Foundation

extension WLRequest {
    var url: URL {
        path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
    }
    
    func toURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        
        var adapters: [RequestAdapter] = [
            HTTPMethodAdapter(method: method),
            ContentTypeAdapter(contentType: contentType)
        ]
        
        if method == .GET {
            if let parameters {
                adapters = adapters + [URLQueryAdapter(parameters: parameters)] + self.adapters
            }
            else {
                adapters = adapters + self.adapters
            }
        }
       
        if method == .POST {
            switch contentType {
            case .json:
                adapters.append(JsonParameterAdapter(parameters: parameters))
                
            default:
                break
            }
            adapters = adapters + self.adapters
        }
        
        try adapters.forEach { try $0.adapted(&urlRequest) }
        return urlRequest
    }
}
