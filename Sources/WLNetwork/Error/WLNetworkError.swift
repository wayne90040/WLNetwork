public enum WLNetworkError: Error {
    case requestFailed(reason: RequestFailed)

    case decisionFailed(reason: DecisionFailed)

    case sessionFailed(reason: SessionFaild)
}

public extension WLNetworkError {
    enum DecisionFailed {
        case missingDefine

        case emptyDecision

        case stop(Error)
    }
}

public extension WLNetworkError {
    enum SessionFaild {
        case failed(Error)

        case missingResponse
    }
}
