public struct JsonParameterAdapter: RequestAdapter, Parameterable {
    
    public var parameters: Parameters

    public init(parameters: Parameters) {
        self.parameters = parameters
    }
    
    public func adapted(_ request: inout URLRequest) throws {
        do {
            let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = body
        }
        catch {
            throw WLNetworkError.requestFailed(reason: .jsonEncodeFailed(error))
        }
    }
}
