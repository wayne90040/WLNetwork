public enum ContentType {
    case none
    case formUrlEncoded
    case json
    case custom(String)
}

public extension ContentType {
    var value: String {
        switch self {
        case .none:
            ""
        case .formUrlEncoded:
            "application/x-www-form-urlencoded; charset=utf-8"
        case .json:
            "application/json"
        case .custom(let type):
            type
        }
    }
    
    var adapter: AnyRequestAdapter? {
        switch self {
        case .none:
            return nil
            
        case .formUrlEncoded, .json:
            return .init {
                $0.setValue(value, forHTTPHeaderField: "Content-Type")
            }
            
        case .custom(let string):
            return .init {
                $0.setValue(string, forHTTPHeaderField: "Content-Type")
            }
        }
    }
}
