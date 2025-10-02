//
//  ContactsScreen.swift
//  mypapers
//
//  Created by Andrey Lechev on 01/10/2025.
//

import SwiftUI
import SwiftData

struct ContactsScreen: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var contacts: [Contact]
  @Binding var selectedContactID: String?
  
  let manager = ContactsManager()
    
    var body: some View {
      if contacts.isEmpty {
        ContentUnavailableView {
          Label("No Contacts found", systemImage: "person.fill.questionmark")
        } description: {
          Text("Fill your contacts list using:")
        } actions: {
          Button("Mock contacts") {
            manager.seedMockContacts(modelContext: modelContext)
          }
        }
        .onAppear {
          // Seed mock data if no contacts
          manager.seedMockContacts(modelContext: modelContext)
        }
      } else if selectedContactID != nil {
            // Compact list when contact is selected (three-pane mode)
            List(contacts, selection: $selectedContactID) { contact in
                VStack(alignment: .leading) {
                    Text(contact.names.stringValue ?? "Unknown")
                        .font(.headline)
                    if let email = contact.email?.first?.stringValue {
                        Text(email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Contacts")
        } else {
            // Full table when no contact selected (two-pane mode)
          Table(contacts, selection: $selectedContactID) {
                TableColumn("Name") { contact in
                    Text(contact.names.stringValue ?? "Unknown")
                }
                TableColumn("Email") { contact in
                    Text(contact.email?.first?.stringValue ?? "")
                }
                TableColumn("Phone") { contact in
                    Text(contact.phone?.first?.stringValue ?? "")
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactsScreen(selectedContactID: .constant(nil))
        .modelContainer(for: Contact.self)
}
