import MultipartKit
import Foundation
import NIOCore
import NIOFoundationCompat

public struct FormDataEncoder: Encodable {

    public enum Error: Swift.Error {
        case failedToUTF8
        case multipartIsNil
    }
    
    public init() { }
    
    public let boundary = UUID()
    
    public func encode<T: Encodable>(_ value: T) throws -> Data {
        do {
            if let convertible = value as? CustomFormDataConvertible {
                let data = try convertible.encode(boundary: boundary)
                return data
            }
            
            if let convertible = value as? any MixFilesFormDataConvertible {
                let data = try encode(convertible)
                return data
            }
            
            if let convertible = value as? any MixFormDataConvertible {
                let data = try encode(convertible)
                return data
            }
            
            if let convertible = value as? [FileFormDataConvertible] {
                let data = try encode(convertible)
                return data
            }
            
            if let convertible = value as? FileFormDataConvertible {
                if let part = convertible.multipart {
                    var buffer = ByteBufferAllocator().buffer(capacity: 0)
                    try MultipartSerializer().serialize(parts: [part], boundary: "\(boundary)", into: &buffer)
                    return Data(buffer: buffer)
                }
                else {
                    throw WLNetworkError.encodeFailed(Error.multipartIsNil)
                }
            }
            
            var data = Data()
            try serializeText(value, into: &data)
            return data
        }
        catch {
            throw WLNetworkError.encodeFailed(error)
        }
    }
    
    /// 解析多個檔案配文字
    private func encode(_ value: some MixFilesFormDataConvertible) throws -> Data {
        var data = Data()
        for file in value.files {
            try serializeFile(file, into: &data)
        }
        
        try serializeText(value.texts, into: &data)
        return data
    }
    
    /// 解析單個檔案配文字
    private func encode(_ value: some MixFormDataConvertible) throws -> Data {
        var data = Data()
        try serializeFile(value.file, into: &data)
        try serializeText(value.texts, into: &data)
        return data
    }
    
    private func encode(_ value: [FileFormDataConvertible]) throws -> Data {
        var data = Data()
        for file in value {
            try serializeFile(file, into: &data)
        }
        return data
    }
    
    /// 解析成文字
    private func serializeText<T: Encodable>(_ value: T, into data: inout Data) throws {
        let string = try MultipartKit.FormDataEncoder().encode(value, boundary: "\(boundary)")
        guard let stringData = string.data(using: .utf8) else {
            throw WLNetworkError.encodeFailed(Error.failedToUTF8)
        }
        data.append(stringData)
    }
    
    /// 解析成檔案
    private func serializeFile<T: FileFormDataConvertible>(_ value: T, into data: inout Data) throws {
        if let part = value.multipart {
            var buffer = ByteBufferAllocator().buffer(capacity: 0)
            try MultipartSerializer().serializeSingle(parts: [part], boundary: "\(boundary)", into: &buffer)
            data.append(.init(buffer: buffer))
        }
        else {
            throw WLNetworkError.encodeFailed(Error.multipartIsNil)
        }
    }
}
