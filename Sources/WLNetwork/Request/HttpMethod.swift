public enum HttpMethod: String {
    case Get = "Get"
    case Post = "Post"
    case Put = "Put"
    case Delete = "Delete"
}

public extension HttpMethod {
    var adapter: AnyRequestAdapter {
        .init {
            $0.httpMethod = rawValue
        }
    }
}
