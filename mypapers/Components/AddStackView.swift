//
//  AddStackView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct AddStackView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Stack.order) private var stacks: [Stack]

  @State private var name = ""
  @State private var selectedType: StackType = .collection
    
  var body: some View {
    Dialog(
      title: "new_stack",
      description: "new_stack_description",
      content: {
        GridRow {
          Text("stack_type_label")
            .font(.caption)
            .gridColumnAlignment(.trailing)
          Picker("stack_type_label", selection: $selectedType) {
            ForEach([StackType.collection, .project, .trip, .folder], id: \.self) { type in
              Label(type.displayName, systemImage: type.iconName).tag(type)
            }
          }
          .labelsHidden()
          .gridColumnAlignment(.leading)
        }
        
        GridRow {
          Text("stack_name_label")
            .font(.caption)
            .gridColumnAlignment(.trailing)
          TextField("stack_name_label", text: $name)
            .labelsHidden()
            .gridColumnAlignment(.leading)
            .onSubmit {
              addStack()
              dismiss()
            }
        }
      },
      actions: {
        DialogButton(
          title: "cancel",
          action: { dismiss() }
        )
        .keyboardShortcut(.cancelAction)
        DialogButton(
          title: "add",
          action: {
            addStack()
            dismiss()
          }
        )
        .disabled(name.isEmpty)
        .keyboardShortcut(.defaultAction)
      }
    )
  }
    
  private func addStack() {
    if !name.isEmpty {
      let newStack = Stack(id: UUID().uuidString, name: name, type: selectedType, order: stacks.count)
      modelContext.insert(newStack)
    }
  }
}

#Preview {
  AddStackView()
}
