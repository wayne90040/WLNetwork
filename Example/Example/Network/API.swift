import WLNetwork

enum API {
    static func getStockTW(completion: @escaping(Result<StockTWResponse, Error>) -> Void) {
        let req = StockTWRequest(parameters: .init(
            period1: "1626969600",
            period2: "1627277400",
            interval: "1d",
            events: "history")
        )
        WLClient(session: .shared).send(req , completion: completion)
    }
    
    static func getStockTW() async -> Result<StockTWResponse, Error> {
        let req = StockTWRequest(parameters: .init(
            period1: "1626969600",
            period2: "1627277400",
            interval: "1d",
            events: "history")
        )
        return await WLClient(session: .shared).sendAsync(req)
    }
}

extension WLRequest {
    func send() async throws -> Self.Response? {
        try await WLClient(session: .shared).trySend(self)
    }
}
