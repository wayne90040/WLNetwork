import WLNetwork

struct StockTWParameters: Encodable {
    let period1: String
    let period2: String
    let interval: String
    let events: String
}

struct StockTWRequest: WLRequest {
    typealias Response = StockTWResponse
   
    let method: HttpMethod = .GET
    let contentType: ContentType = .json
    let path: String = "/v8/finance/chart/2330.TW"
    
    var decisions: [Decision] = [
        JsonDecodeDecision()
    ]
    
    let parameters: StockTWParameters?
}

extension WLRequest {
    var baseURL: URL {
        .init(string: "https://query1.finance.yahoo.com")!
    }
}
