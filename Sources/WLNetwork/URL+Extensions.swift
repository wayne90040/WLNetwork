import Foundation

extension URL {
    func appendingPathComponentIfNotEmpty<T: Request>(_ request: T) -> URL {
        request.path.isEmpty ? self : appendingPathComponent(request.path)
    }

    func appendingQueryItems<T: Request>(_ request: T) -> URL {
        guard request.method == .Get else {
            return self
        }
        guard let items = request.queries else {
            return self
        }
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }
        components.queryItems = items
        return components.url ?? self
    }
}
