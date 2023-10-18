//
//  HomeViewModel.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/29/23.
//

import Foundation

extension HomeView {
    @MainActor
    final class HomeViewModel: ObservableObject {
        @Published var isLoading = false
        @Published var showReminderOptions = false
        @Published var sheetState: HomeViewState?
        @Published var memories = [Memory]()
        private var memoryStorage: MemoryStorage
        
        init(memoryStorage: MemoryStorage) {
            self.memoryStorage = memoryStorage
        }
        
        func getMemoryStorage() -> MemoryStorage {
            return memoryStorage
        }
        
        func getUpdatedMemories() {
            Task {
                isLoading = true
                let memories = await memoryStorage.fetch()
                self.memories = memories
                isLoading = false
            }
        }
        
        func deleteMemory(indexSet: IndexSet) {
            Task {
                isLoading = true
                guard let memoryToDelete = indexSet.first else { return }
                let memory = memories[memoryToDelete]
                await memoryStorage.delete(memory: memory)
                memories.remove(at: memoryToDelete)
                isLoading = false
            }
        }
    }
    
    enum HomeViewState: Identifiable {
        var id: Int {
            hashValue
        }
        case audioRecording
        case text
    }
}
