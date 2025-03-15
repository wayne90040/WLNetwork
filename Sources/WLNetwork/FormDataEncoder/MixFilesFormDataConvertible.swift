import MultipartKit
import Foundation

public protocol MixFilesFormDataConvertible: Encodable {
    associatedtype FileParameter: FileFormDataConvertible
    associatedtype TextParameter: Encodable
    
    var files: [FileParameter] { get set }
    var texts: TextParameter { get set }
}
