//
//  NoteWriterViewModel.swift
//  MyMemo
//
//  Created by Vince Carlo Santos on 9/20/23.
//

import Foundation

final class NoteWriterViewModel: ObservableObject {
    var notes = ""
    var title = ""
    var memoryStorage: MemoryStorage
    
    init(memoryStorage: MemoryStorage) {
        self.memoryStorage = memoryStorage
    }
    
    func saveToDatabase() {
        guard let notesData = notes.data(using: .utf8) else { return }
        memoryStorage.addMemory(data: notesData, name: title, type: .text)
    }
}
