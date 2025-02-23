public enum WLNetworkError: Error {
    case decodeFailed(Error)
    case encodeFailed(Error)
    case responseIsNil
    case urlIsNil
    case urlComponentIsNil
    case error(Error)
    case decisionIsEmpty
    case stopDecision(Error)
}
