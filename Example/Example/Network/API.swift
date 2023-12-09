import WLNetwork

enum API {
    
    
    static func getStockTW(completion: @escaping(Result<StockTWResponse, Error>) -> Void) {
        Session.init(session: .shared).send(StockTWRequest(), completion: completion)
    }
    
    static func getStockTW() async -> Result<StockTWResponse, Error> {
        await Session.init(session: .shared).send(StockTWRequest())
    }
}
