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
}
