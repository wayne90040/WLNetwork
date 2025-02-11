public enum ContentType {
    case formData
    case json
    case custom(String)
    
    public var value: String {
        switch self {
        case .formData: "multipart/form-data"
        case .json: "application/json"
        case .custom(let string): string
        }
    }
}
