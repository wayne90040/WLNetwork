public struct AnyRequestAdapter: RequestAdapter {

    public var block: (inout URLRequest) throws -> Void
    
    public func adapted(_ request: inout URLRequest) throws {
        try block(&request)
    }
}
