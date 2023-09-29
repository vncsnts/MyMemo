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
        var memoryStorage: MemoryStorage
        
        init(memoryStorage: MemoryStorage) {
            self.memoryStorage = memoryStorage
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
