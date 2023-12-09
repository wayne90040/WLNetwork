public enum ContentType {
    case none
    case formUrlEncoded
    case json
}

public extension ContentType {
    var value: String {
        switch self {
        case .none:
            return ""
        case .formUrlEncoded:
            return "application/x-www-form-urlencoded; charset=utf-8"
        case .json:
            return "application/json"
        }
    }
    
    var adapter: AnyRequestAdapter? {
        if self == .none {
            return nil
        }
        return .init {
            $0.setValue(value, forHTTPHeaderField: "Content-Type")
        }
    }
}
