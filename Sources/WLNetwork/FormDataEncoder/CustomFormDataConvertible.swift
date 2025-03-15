import Foundation

public protocol CustomFormDataConvertible {
    func encode(boundary: UUID) throws -> Data
}
