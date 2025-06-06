import Foundation

extension WLRequest {
    func toURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        
        var adapters: [RequestAdapter] = [
            HTTPMethodAdapter(method: method),
            ContentTypeAdapter(contentType: contentType)
        ]
        
        if method == .GET, let parameters {
            adapters = adapters + [URLQueryAdapter(parameters: parameters)]
        }
        
        if method == .POST {
            switch contentType {
            case .json: adapters.append(JsonParameterAdapter(parameters: parameters))
            case .formData: adapters.append(FormDataEncodeAdapter(parameters: parameters))
            default: break
            }
        }
        
        adapters = adapters + self.adapters
        
        try adapters.forEach { try $0.adapted(&urlRequest) }
        return urlRequest
    }
}
