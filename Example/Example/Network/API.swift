import WLNetwork

enum API {
    
    
    static func getStockTW(completion: @escaping(Result<StockTWResponse, Error>) -> Void) {
        Session.init(session: .shared).send(StockTWRequest(), completion: completion)
    }
    
    
    
    
}
