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
    TabView {
      ContactsList(selectedContactID: $selectedContactID)
        .tabItem {
          Text("contacts")
        }
      Text("Contact Details Content")
        .tabItem {
          Text("Contact Details")
        }
    }
    .tabViewStyle(.grouped)
  }
}

#Preview {
    ContactsScreen(selectedContactID: .constant(nil))
        .modelContainer(for: Contact.self)
}
