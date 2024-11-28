import Foundation

public struct FormURLEncodeAdaper: RequestAdapter, Parameterable {

    public var parameters: Parameters

    public init(parameters: Parameters) {
        self.parameters = parameters
    }

    public func adapted(_ request: inout URLRequest) throws {
        // TODO: Not implement
    }
}
