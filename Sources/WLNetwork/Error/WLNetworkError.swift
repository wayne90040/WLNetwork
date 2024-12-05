public enum WLNetworkError: Error {
    
    public enum CrtReqFailed {
        
        case jsonEncodeFailed(Error)
        
        case missingURL
        
        case URLComponentNil
    }
    
    public enum DecisionFailed {
        case missingDefine
        case emptyDecision
        case stop(Error)
    }
    
    public enum SendFailed {
        case failed(Error)

        case missingResponse
    }
    
    case crtReqFailed(CrtReqFailed)

    case decisionFailed(DecisionFailed)

    case sendFailed(SendFailed)
}
