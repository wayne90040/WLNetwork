//
//  File.swift
//  
//
//  Created by HSUWEILUN on 2024/12/7.
//

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
