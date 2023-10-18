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
                let memories = await memoryStorage.fetch()
                self.memories = memories
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
