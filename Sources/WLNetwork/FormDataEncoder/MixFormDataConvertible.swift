import MultipartKit
import Foundation

protocol MixFormDataConvertible: Encodable {
    associatedtype FileParameter: FileFormDataConvertible
    associatedtype TextParameter: Encodable
    
    var file: FileParameter { get set }
    var texts: TextParameter { get set }
}

