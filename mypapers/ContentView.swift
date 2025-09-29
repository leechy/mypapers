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

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text(String(format: NSLocalizedString("item_detail", comment: ""), item.title))
                    } label: {
                        Text(item.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                    Button(action: addItem) {
                        Label("add_item", systemImage: "plus")
                    }
            }
        } detail: {
            Text("select_an_item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), localizedTitles: ["en": "New Item"])
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
