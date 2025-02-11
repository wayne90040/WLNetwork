import Foundation

public struct FormDataEncodeAdapter: RequestAdapter {
    public var parameters: Encodable

    public init(parameters: Encodable) {
        self.parameters = parameters
    }

    public func adapted(_ request: inout URLRequest) throws {
        do {
            let body = try FormDataEncoder().encode(parameters)
            request.httpBody = body
        }
        catch {
            throw WLNetworkError.encodeFailed(error)
        }
    }
}
