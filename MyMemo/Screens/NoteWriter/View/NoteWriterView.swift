//
//  NoteWriterView.swift
//  MyMemo
//
//  Created by Vince Carlo Santos on 9/20/23.
//

import SwiftUI

struct NoteWriterView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var memoryStorage: MemoryStorage
    @StateObject var viewModel: NoteWriterViewModel
    
    init(memoryStorage: MemoryStorage) {
        self.memoryStorage = memoryStorage
        _viewModel = StateObject(wrappedValue: NoteWriterViewModel(memoryStorage: memoryStorage))
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField("Enter a title...", text: $viewModel.title)
                        .font(.headline)
                    Spacer()
                    Button("Save") {
                        viewModel.saveToDatabase()
                        dismiss()
                    }
                }
                Divider()
                TextEditor(text: $viewModel.notes)
                    .font(.caption)
            }
            .padding()
        }
    }
}

#Preview {
    NoteWriterView(memoryStorage: MemoryStorage())
}
