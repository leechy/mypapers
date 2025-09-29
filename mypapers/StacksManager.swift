//
//  StacksManager.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

class StacksManager {
    
    func insertSystemStacksIfNeeded(stacks: [Stack], modelContext: ModelContext) {
        if !stacks.contains(where: { $0.id == "all_papers" }) {
            let allPapersStack = Stack(id: "all_papers", name: "All Papers", type: .folder)
            modelContext.insert(allPapersStack)
        }
    }
    
    func deleteStacks(at offsets: IndexSet, from stacks: [Stack], modelContext: ModelContext) {
        withAnimation {
            for index in offsets {
                if !stacks[index].isSystem {
                    modelContext.delete(stacks[index])
                }
            }
        }
    }
    
    func moveStacks(from source: IndexSet, to destination: Int, stacks: [Stack]) {
        // Note: "All Papers" should always be first, so we need to handle that
        var reordered = Array(stacks)
        reordered.move(fromOffsets: source, toOffset: destination)
        
        // Ensure "All Papers" stays at index 0
        if let allPapersIndex = reordered.firstIndex(where: { $0.isSystem }) {
            if allPapersIndex != 0 {
                let allPapers = reordered.remove(at: allPapersIndex)
                reordered.insert(allPapers, at: 0)
            }
        }
        
        for (index, stack) in reordered.enumerated() {
            // We might need an order property if we want custom ordering
            // For now, just ensure system stack is first
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