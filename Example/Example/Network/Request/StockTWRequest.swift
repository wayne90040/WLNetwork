import WLNetwork

struct StockTWRequest: Request {
    
    typealias Response = StockTWResponse
    
    var method: HttpMethod = .Get
    
    var contentType: ContentType = .json
    
    var path: String = "/v8/finance/chart/2330.TW"
    
    var queries: [URLQueryItem]? = [
        .init(name: "period1", value: "1626969600"),
        .init(name: "period2", value: "1627277400"),
        .init(name: "interval", value: "1d"),
        .init(name: "events", value: "history"),
        .init(name: "", value: "hP2rOschxO0")
    ]

    var parameters: Parameters? = [
        "period1": "1626969600",
        "period2": "1627277400",
        "interval": "1d",
        "events": "history",
        "": "hP2rOschxO0"
    ]
    
    var decisions: [Decision] = [
        JsonDecodeDecision()
    ]
}

extension Request {
    var baseURL: URL {
        .init(string: "https://query1.finance.yahoo.com")!
    }
}
