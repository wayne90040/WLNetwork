import Foundation

public struct FormDataEncodeAdapter: RequestAdapter {
    public var parameters: Encodable

    public init(parameters: Encodable) {
        self.parameters = parameters
    }

    public func adapted(_ request: inout URLRequest) throws {
        do {
            let encoder = FormDataEncoder()
            let body = try encoder.encode(parameters)
            let boundary = encoder.boundary.uuidString
            request.setValue(ContentType.formData.value + "; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        catch {
            throw WLNetworkError.encodeFailed(error)
        }
    }
}
