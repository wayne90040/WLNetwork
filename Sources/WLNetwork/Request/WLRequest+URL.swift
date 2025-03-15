import Foundation

extension WLRequest {
    var url: URL {
        path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
    }
}
