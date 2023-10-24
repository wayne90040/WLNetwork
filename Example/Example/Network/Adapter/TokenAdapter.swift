import WLNetwork

struct TokenAdapter: RequestAdapter {
    
    let token: String?
    
    func adapted(_ request: inout URLRequest) throws {
        guard let token = token else {
            return
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}
