import WLNetwork

struct JsonDecodeDecision: Decision {
        
    func shouldApply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse) -> Bool {
        true
    }
    
    func apply<T: Request>(_ request: T, data: Data, response: HTTPURLResponse, completion: @escaping (DecisionAction<T>) -> Void) {
        do {
            let value = try JSONDecoder().decode(T.Response.self, from: data)
            completion(.done(value))
        }
        catch { }
    }
}
