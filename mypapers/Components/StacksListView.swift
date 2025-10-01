//
//  StacksListView.swift
//  mypapers
//
//  Created by Andrey Lechev on 30/09/2025.
//

import SwiftUI
import SwiftData

struct StacksListView: View {
  @Environment(\.modelContext) private var modelContext
  
  @Binding var showingAddStack: Bool

  private let stacksManager = StacksManager()
  @Query(sort: \Stack.order) private var stacks: [Stack]
  
  @State private var stacksExpanded = true

  @State private var editingStack: Stack? = nil
  @State private var editedStackName = ""
  @FocusState private var isEditingFocused: Bool

  var body: some View {
    Section("stacks", isExpanded: $stacksExpanded) {
      ForEach(stacks, id: \.prefixedID) { stack in
        if editingStack?.id == stack.id {
          HStack {
            Image(systemName: stack.iconName)
            TextField("", text: $editedStackName)
              .focused($isEditingFocused)
              .onSubmit(commitRename)
              .onKeyPress(.escape) {
                cancelRename()
                return .handled
              }
              .onChange(of: isEditingFocused) {
                if !isEditingFocused {
                  cancelRename()
                }
              }
              .onAppear {
                editedStackName = stack.name
                isEditingFocused = true
              }
          }
        } else {
          NavigationLink(value: stack.prefixedID) {
            Label(stack.name, systemImage: stack.iconName)
          }
          .contextMenu {
            Section {
              Button {
                showingAddStack = true
              } label: {
                Label("new_stack", systemImage: "folder.badge.plus")
              }
            }
            Section {
              Button {
                startRenaming(stack)
              } label: {
                Label("rename_stack", systemImage: "pencil")
              }
              Button(role: .destructive) {
                stacksManager.deleteStack(stack, modelContext: modelContext)
              } label: {
                Label("delete_stack", systemImage: "trash")
              }
            }
          }
        }
      }
      .onDelete(perform: { offsets in
        stacksManager.deleteStacks(
          at: offsets,
          from: stacks,
          modelContext: modelContext
        )
      })
      .onMove(perform: { source, dest in
        stacksManager.moveStacks(
          from: source,
          to: dest,
          stacks: stacks
        )
      })
    }
    .sectionActions {
      Button(action: { showingAddStack = true }) {
        Label("add_stack", systemImage: "plus.circle")
          .font(.title3)
      }
    }
  }
  
  private func startRenaming(_ stack: Stack) {
    editingStack = stack
    editedStackName = stack.name
  }
  
  private func commitRename() {
    if let stack = editingStack {
      let newName = editedStackName.trimmingCharacters(in: .whitespacesAndNewlines)
      if !newName.isEmpty {
        stack.name = newName
        try? modelContext.save()
      }
    }
    editingStack = nil
    editedStackName = ""
  }

  private func cancelRename() {
    editingStack = nil
    editedStackName = ""
  }
}

#Preview {
  List {
    StacksListView(showingAddStack: .constant(false))
  }
  .modelContainer(for: [Stack.self], inMemory: true)
}

