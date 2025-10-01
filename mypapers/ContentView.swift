//
//  ContentView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]

  @State var showingAddStack = false
  @State var showingAddCategory = false
  @State private var drawerSelection: String? = "dashboard"

  var body: some View {
    NavigationSplitView(sidebar: {
      List(selection: $drawerSelection) {
        NavigationLink(value: "dashboard") {
          Label(String(format: NSLocalizedString("dashboard", comment: "")), systemImage: "rectangle.3.group")
        }
        NavigationLink(value: "all_papers") {
          Label(String(format: NSLocalizedString("all_papers", comment: "")), systemImage: "rectangle.grid.2x2")
        }
        NavigationLink(value: "contacts") {
          Label(String(format: NSLocalizedString("contacts", comment: "")), systemImage: "person.2")
        }
        StacksListView(
          showingAddStack: $showingAddStack
        )
        CategoriesListView(
          showingAddCategory: $showingAddCategory
        )
      }
      .frame(maxHeight: .infinity)
      .navigationSplitViewColumnWidth(min: 220, ideal: 280)

    }, detail: {
      if let selection = drawerSelection {
        switch selection {
        case "dashboard":
          DashboardScreen()
        case "all_papers":
          PapersScreen()
        case "contacts":
          ContactsScreen()
        case _ where selection.hasPrefix("stack_"):
          PapersScreen()
        case _ where selection.hasPrefix("category_"):
          PapersScreen()
        default:
          Text("Unknown destination: \(selection)")
        }
      } else {
        Text("select_an_item")
      }
    })
    .sheet(isPresented: $showingAddCategory) {
      AddCategoryView()
    }
    .sheet(isPresented: $showingAddStack) {
      AddStackView()
    }
  }


  private func addItem() {
    withAnimation {
      let newItem = Item(timestamp: Date(), localizedTitles: ["en": "New Item"], categories: [])
      modelContext.insert(newItem)
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: [Item.self, Category.self, Stack.self], inMemory: true)
}
