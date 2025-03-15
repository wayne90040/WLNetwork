import MultipartKit
import Foundation

extension MultipartSerializer {
    public func serializeSingle(parts: [MultipartPart], boundary: String, into buffer: inout ByteBuffer) throws {
        for part in parts {
            buffer.writeString("--")
            buffer.writeString(boundary)
            buffer.writeString("\r\n")
            for (key, val) in part.headers {
                buffer.writeString(key)
                buffer.writeString(": ")
                buffer.writeString(val)
                buffer.writeString("\r\n")
            }
            buffer.writeString("\r\n")
            var body = part.body
            buffer.writeBuffer(&body)
            buffer.writeString("\r\n")
        }
    }
    
    public func serializeEnding(boundary: String, into buffer: inout ByteBuffer) {
        buffer.writeString("--")
        buffer.writeString(boundary)
        buffer.writeString("--\r\n")
    }
}
