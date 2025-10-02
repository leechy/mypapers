import Foundation
import SwiftData

@Model
class Contact {
    @Attribute(.unique) var id: String
    var names: FieldValue
    var displayName: FieldValue?
    var otherNames: [FieldValue]?
    var birthdate: FieldValue?
    var occupation: FieldValue?
    var personalNumber: [FieldValue]?
    var business: [FieldValue]?
    var phone: [FieldValue]?
    var email: [FieldValue]?
    var address: [FieldValue]?
    var notes: FieldValue?
    var iban: [FieldValue]?
    var favorite: Bool
    var avatar: Data?
    
    init(id: String, names: FieldValue, favorite: Bool) {
        self.id = id
        self.names = names
        self.favorite = favorite
    }
}
