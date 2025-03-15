public enum ContentType {
    case formData
    case json
    case none
    case custom(String)
    
    public var value: String {
        switch self {
        case .formData: "multipart/form-data"
        case .json: "application/json"
        case .none: ""
        case .custom(let string): string
        }
    }
}
