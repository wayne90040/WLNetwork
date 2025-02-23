import MultipartKit
import Foundation
import NIOCore
import NIOFoundationCompat

public struct FormDataEncoder: Encodable {

    public enum Error: Swift.Error {
        case failedToUTF8
    }
    
    public init() { }
    
    public let boundary = UUID()
    
    public func encode<T: Encodable>(_ value: T) throws -> Data {
        if let part = value as? MultipartPartConvertible, let multipart = part.multipart {
            var buffer = ByteBufferAllocator().buffer(capacity: 0)
            try MultipartSerializer().serialize(parts: [multipart], boundary: "\(boundary)", into: &buffer)
            return Data(buffer: buffer)
        }
        else {
            let serial = try MultipartKit.FormDataEncoder().encode(value, boundary: "\(boundary)")
            guard let data = serial.data(using: .utf8) else {
                throw WLNetworkError.encodeFailed(Error.failedToUTF8)
            }
            return data
        }
    }
}
