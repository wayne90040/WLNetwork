//
//  File.swift
//  
//
//  Created by HSUWEILUN on 2024/12/7.
//

import Foundation

public struct ParameterAdapter: RequestAdapter {
    
    public var method: HttpMethod
    
    public var contentType: ContentType
    
    public var parameters: Parameters?
   
    public init(_ method: HttpMethod,  contentType: ContentType, parameters: Parameters?) {
        self.method = method
        self.contentType = contentType
        self.parameters = parameters
    }
    
    public func adapted(_ request: inout URLRequest) throws {

        switch (method, contentType) {
        case (.Get, _):
            try handleURLQuery(&request)
            
        case (_, .formUrlEncoded):
            // TODO: Need to do implement
            break
            
        case (_, .json):
            try handleJSON(&request)
            
        case (_, .none):
            break
        }
    }
    
    private func handleURLQuery(_ req: inout URLRequest) throws {
        guard let parameters else {
            return
        }
        
        guard let url = req.url else {
            throw WLNetworkError.crtReqFailed(.missingURL)
        }
    
        let queries = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw WLNetworkError.crtReqFailed(.URLComponentNil)
        }
        
        components.queryItems = queries
        req.url = components.url
    }
    
    private func handleJSON(_ req: inout URLRequest) throws {
        guard let parameters else {
            return
        }
        
        do {
            let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
            req.httpBody = body
        }
        catch {
            throw WLNetworkError.crtReqFailed(.jsonEncodeFailed(error))
        }
    }
}
