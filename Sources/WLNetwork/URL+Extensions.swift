import Foundation

extension URL {
    func appendingPathComponentIfNotEmpty<T: WLRequest>(_ request: T) -> URL {
        request.path.isEmpty ? self : appendingPathComponent(request.path)
    }
}
