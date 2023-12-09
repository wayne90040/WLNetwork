import Foundation

public protocol RequestAdapter {
    func adapted(_ request: inout URLRequest) throws
}

public protocol Parameterable {
    var parameters: Parameters { get set }
}
