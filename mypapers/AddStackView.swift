//
//  AddStackView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct AddStackView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var selectedType: StackType = .folder
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("stack_name", text: $name)
                Picker("stack_type", selection: $selectedType) {
                    ForEach([StackType.folder, .project, .collection, .trip], id: \.self) { type in
                        Label(type.displayName, systemImage: type.iconName).tag(type)
                    }
                }
            }
            .navigationTitle("add_stack")
//            .navigationBarItems(leading: Button("cancel") { dismiss() },
//                                trailing: Button("add") { addStack() }.disabled(name.isEmpty))
        }
    }
    
    private func addStack() {
        let newStack = Stack(id: UUID().uuidString, name: name, type: selectedType)
        modelContext.insert(newStack)
        dismiss()
    }
}
