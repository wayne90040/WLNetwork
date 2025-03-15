import MultipartKit
import Foundation

/// 單個檔案
public protocol FileFormDataConvertible: MultipartPartConvertible, Encodable {
    /// File Label
    var file: String { get }
    var filename: String { get set }
    var contentType: String { get set }
    var data: Data { get set }
}

extension FileFormDataConvertible {
    public var file: String {
        "file"
    }
    
    public var multipart: MultipartPart? {
        MultipartPart(
            headers: [
                "Content-Type": contentType,
                "Content-Disposition": "form-data; name=\"\(file)\";filename=\"\(filename)\""
            ],
            body: data)
    }
    
    public init?(multipart: MultipartPart) {
        nil
    }
}
