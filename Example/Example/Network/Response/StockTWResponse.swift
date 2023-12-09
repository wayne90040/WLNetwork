struct StockTWResponse: Codable {
    var chart: Chart?
}

extension StockTWResponse {
    struct Chart: Codable {
        let result: [Result]
        let error: String?
    }
}

extension StockTWResponse.Chart {
    struct Result: Codable {
        let meta: Meta
        let timestamp: [Int]
    }
}

extension StockTWResponse.Chart.Result {
    struct Meta: Codable {
        let currency: String
        let symbol: String
    }
}
