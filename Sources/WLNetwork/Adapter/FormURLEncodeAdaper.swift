import Foundation

public struct FormURLEncodeAdaper: RequestAdapter {

    public var parameters: Encodable

    public init(parameters: Encodable) {
        self.parameters = parameters
    }

    public func adapted(_ request: inout URLRequest) throws {
        // TODO: Not implement
    }
}
