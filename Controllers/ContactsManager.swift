//
//  ContactsManager.swift
//  mypapers
//
//  Created by Andrey Lechev on 02/10/2025.
//

import SwiftUI
import SwiftData

class ContactsManager {
    
    func createContact(id: String, names: FieldValue, favorite: Bool = false, modelContext: ModelContext) -> Contact {
        let contact = Contact(id: id, names: names, favorite: favorite)
        modelContext.insert(contact)
        try? modelContext.save()
        return contact
    }
    
    func deleteContact(_ contact: Contact, modelContext: ModelContext) {
        modelContext.delete(contact)
        try? modelContext.save()
    }
    
    func deleteContacts(at offsets: IndexSet, from contacts: [Contact], modelContext: ModelContext) {
        withAnimation {
            for index in offsets {
                modelContext.delete(contacts[index])
            }
        }
        try? modelContext.save()
    }
    
    // Generic field update method
    func updateContactField<T>(_ contact: inout Contact, keyPath: WritableKeyPath<Contact, T>, value: T, modelContext: ModelContext) {
        contact[keyPath: keyPath] = value
        try? modelContext.save()
    }
    
    // Array field operations
    func addToContactArrayField(_ contact: inout Contact, keyPath: WritableKeyPath<Contact, [FieldValue]?>, value: FieldValue, modelContext: ModelContext) {
        if contact[keyPath: keyPath] == nil {
            contact[keyPath: keyPath] = [value]
        } else {
            contact[keyPath: keyPath]?.append(value)
        }
        try? modelContext.save()
    }
    
    func removeFromContactArrayField(_ contact: inout Contact, keyPath: WritableKeyPath<Contact, [FieldValue]?>, value: FieldValue, modelContext: ModelContext) {
        contact[keyPath: keyPath]?.removeAll { $0.value == value.value && $0.label == value.label && $0.currency == value.currency }
        try? modelContext.save()
    }
    
    func updateContactArrayFieldAtIndex(_ contact: inout Contact, keyPath: WritableKeyPath<Contact, [FieldValue]?>, index: Int, value: FieldValue, modelContext: ModelContext) {
        if let array = contact[keyPath: keyPath], index >= 0 && index < array.count {
            contact[keyPath: keyPath]?[index] = value
            try? modelContext.save()
        }
    }
}
