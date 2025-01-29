public enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

public extension HttpMethod {
    var adapter: AnyRequestAdapter {
        .init {
            $0.httpMethod = rawValue
        }
    }
}
