import Foundation

public protocol RequestAdapter {
    func adapted(_ request: inout URLRequest) throws
}
