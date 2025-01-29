import Foundation

public struct QueryParamEncoder {
    
    public init() { }
    
    public func encode<T: Encodable>(_ item: T) throws -> String {
        let encoder = DictionaryEncoder()
        let encoded: [String: Any] = try encoder.encode(item)
        let queryParams = encodeDictionary(encoded)
        
        return "\(queryParams)"
    }
    
    private func encodeDictionary(_ dictionary: [String: Any]) -> String {
        return dictionary
            .compactMap { (key, value) -> String? in
                if value is [String: Any] {
                    if let dictionary = value as? [String: Any] {
                        return encodeDictionary(dictionary)
                    }
                }
                else {
                    return "\(key)=\(value)"
                }
                
                return nil
            }
            .joined(separator: "&")
    }
}
