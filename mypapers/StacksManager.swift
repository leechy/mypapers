//
//  StacksManager.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

class StacksManager {
    
  func deleteStacks(at offsets: IndexSet, from stacks: [Stack], modelContext: ModelContext) {
    withAnimation {
      for index in offsets {
        modelContext.delete(stacks[index])
      }
    }
  }

  func moveStacks(from source: IndexSet, to destination: Int, stacks: [Stack]) {
    var reordered = Array(stacks)
    reordered.move(fromOffsets: source, toOffset: destination)

    for (index, stack) in reordered.enumerated() {
      stack.order = index
    }
  }

  func addPaperToStack(stack: Stack, paperId: String) {
    if !stack.papers.contains(paperId) {
      stack.papers.append(paperId)
    }
  }
  
  func removePaperFromStack(stack: Stack, paperId: String) {
    stack.papers.removeAll { $0 == paperId }
  }
}
