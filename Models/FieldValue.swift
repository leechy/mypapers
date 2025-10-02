import Foundation

struct FieldValue: Codable {
    enum ValueType: Codable, Equatable {
        case string(String)
        case bool(Bool)
        case number(Double)
        case null
    }
    
    var value: ValueType?
    var label: String?
    var currency: String?
    
    var stringValue: String? {
        switch value {
        case .string(let s): return s
        case .bool(let b): return b.description
        case .number(let n): return String(n)
        case .null: return nil
        case .none: return nil
        }
    }
}
