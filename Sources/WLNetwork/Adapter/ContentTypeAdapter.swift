//
//  File.swift
//  
//
//  Created by HSUWEILUN on 2024/12/7.
//

import Foundation

public struct ContentTypeAdapter: RequestAdapter {
    
    public var contentType: ContentType
    
    public init(contentType: ContentType) {
        self.contentType = contentType
    }
    
    public func adapted(_ request: inout URLRequest) throws {
        request.setValue(contentType.value, forHTTPHeaderField: "Content-Type")
    }
}