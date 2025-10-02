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
    
    func seedMockContacts(modelContext: ModelContext) {
        let mockContacts = [
            Contact(id: "contact-1", names: FieldValue(value: .string("John Doe"), label: "Full Name"), favorite: true),
            Contact(id: "contact-2", names: FieldValue(value: .string("Jane Smith"), label: "Full Name"), favorite: false),
            Contact(id: "contact-3", names: FieldValue(value: .string("Alice Johnson"), label: "Full Name"), favorite: true),
            Contact(id: "contact-4", names: FieldValue(value: .string("Bob Brown"), label: "Full Name"), favorite: false),
            Contact(id: "contact-5", names: FieldValue(value: .string("Charlie Wilson"), label: "Full Name"), favorite: true),
            Contact(id: "contact-6", names: FieldValue(value: .string("Diana Lee"), label: "Full Name"), favorite: false),
            Contact(id: "contact-7", names: FieldValue(value: .string("Edward Davis"), label: "Full Name"), favorite: true),
            Contact(id: "contact-8", names: FieldValue(value: .string("Fiona Garcia"), label: "Full Name"), favorite: false),
            Contact(id: "contact-9", names: FieldValue(value: .string("George Miller"), label: "Full Name"), favorite: true),
            Contact(id: "contact-10", names: FieldValue(value: .string("Helen Taylor"), label: "Full Name"), favorite: false),
            Contact(id: "contact-11", names: FieldValue(value: .string("Ian Anderson"), label: "Full Name"), favorite: true),
            Contact(id: "contact-12", names: FieldValue(value: .string("Julia Thomas"), label: "Full Name"), favorite: false),
            Contact(id: "contact-13", names: FieldValue(value: .string("Kevin Jackson"), label: "Full Name"), favorite: true),
            Contact(id: "contact-14", names: FieldValue(value: .string("Laura White"), label: "Full Name"), favorite: false),
            Contact(id: "contact-15", names: FieldValue(value: .string("Michael Harris"), label: "Full Name"), favorite: true),
            Contact(id: "contact-16", names: FieldValue(value: .string("Nancy Martin"), label: "Full Name"), favorite: false),
            Contact(id: "contact-17", names: FieldValue(value: .string("Oliver Clark"), label: "Full Name"), favorite: true),
            Contact(id: "contact-18", names: FieldValue(value: .string("Paula Lewis"), label: "Full Name"), favorite: false),
            Contact(id: "contact-19", names: FieldValue(value: .string("Quincy Robinson"), label: "Full Name"), favorite: true),
            Contact(id: "contact-20", names: FieldValue(value: .string("Rachel Walker"), label: "Full Name"), favorite: false)
        ]
        
        // Add more details to some contacts
        mockContacts[0].phone = [FieldValue(value: .string("123-456-7890"), label: "Home"), FieldValue(value: .string("098-765-4321"), label: "Work")]
        mockContacts[0].email = [FieldValue(value: .string("john.doe@example.com"), label: "Personal")]
        mockContacts[0].address = [FieldValue(value: .string("123 Main St, Anytown, USA"), label: "Home")]
        mockContacts[0].birthdate = FieldValue(value: .string("1990-01-01"), label: "Birth Date")
        mockContacts[0].occupation = FieldValue(value: .string("Software Engineer"), label: "Job Title")
        
        mockContacts[1].phone = [FieldValue(value: .string("555-123-4567"), label: "Mobile")]
        mockContacts[1].email = [FieldValue(value: .string("jane.smith@company.com"), label: "Work")]
        mockContacts[1].notes = FieldValue(value: .string("Met at conference"), label: "Notes")
        
        mockContacts[2].phone = [FieldValue(value: .string("111-222-3333"), label: "Home"), FieldValue(value: .string("444-555-6666"), label: "Mobile")]
        mockContacts[2].email = [FieldValue(value: .string("alice.johnson@gmail.com"), label: "Personal")]
        mockContacts[2].business = [FieldValue(value: .string("Tech Startup Inc."), label: "Company")]
        mockContacts[2].iban = [FieldValue(value: .string("GB29 NWBK 6016 1331 9268 19"), label: "Bank Account")]
        
        mockContacts[3].phone = [FieldValue(value: .string("777-888-9999"), label: "Work")]
        mockContacts[3].address = [FieldValue(value: .string("456 Oak Ave, Somewhere, USA"), label: "Office")]
        mockContacts[3].personalNumber = [FieldValue(value: .string("SSN: 123-45-6789"), label: "Social Security")]
        
        mockContacts[4].email = [FieldValue(value: .string("charlie.wilson@school.edu"), label: "School")]
        mockContacts[4].occupation = FieldValue(value: .string("Teacher"), label: "Profession")
        mockContacts[4].notes = FieldValue(value: .string("Colleague from university"), label: "Notes")
        
        mockContacts[5].phone = [FieldValue(value: .string("222-333-4444"), label: "Mobile")]
        mockContacts[5].birthdate = FieldValue(value: .string("1985-05-15"), label: "Birthday")
        mockContacts[5].otherNames = [FieldValue(value: .string("Diana Lee Martinez"), label: "Maiden Name")]
        
        mockContacts[6].email = [FieldValue(value: .string("edward.davis@lawfirm.com"), label: "Work")]
        mockContacts[6].business = [FieldValue(value: .string("Davis & Associates"), label: "Law Firm")]
        mockContacts[6].iban = [FieldValue(value: .string("US12345678901234567890"), label: "IBAN")]
        
        mockContacts[7].phone = [FieldValue(value: .string("555-666-7777"), label: "Home")]
        mockContacts[7].address = [FieldValue(value: .string("789 Pine St, Elsewhere, USA"), label: "Residence")]
        mockContacts[7].occupation = FieldValue(value: .string("Graphic Designer"), label: "Job")
        
        mockContacts[8].email = [FieldValue(value: .string("george.miller@hospital.org"), label: "Work")]
        mockContacts[8].personalNumber = [FieldValue(value: .string("License: D123456"), label: "Driver's License")]
        mockContacts[8].notes = FieldValue(value: .string("Doctor at local hospital"), label: "Notes")
        
        mockContacts[9].phone = [FieldValue(value: .string("888-999-0000"), label: "Mobile")]
        mockContacts[9].birthdate = FieldValue(value: .string("1978-12-25"), label: "Date of Birth")
        mockContacts[9].otherNames = [FieldValue(value: .string("Helen Taylor-Jones"), label: "Married Name")]
        
        for contact in mockContacts {
            modelContext.insert(contact)
        }
        try? modelContext.save()
    }
}
