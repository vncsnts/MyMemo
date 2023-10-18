//
//  HomeView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel    
    
    init(memoryStorage: MemoryStorage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(memoryStorage: memoryStorage))
    }
    
    var body: some View {
        VStack {
            // MARK - HEADER
            Spacer()
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.2)
                    .padding(64)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            
            //MARK - CENTER
            Text("Here are the latest reminders you have given me.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            List {
                ForEach($viewModel.memories) { memory in
                    Text(memory.name.wrappedValue ?? "")
                }
                .onDelete { indexSet in
                    viewModel.deleteMemory(indexSet: indexSet)
                }
            }
            .listStyle(.plain)
            //MARK - FOOTER
            Spacer()
            
            Button {
                viewModel.showReminderOptions = true
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Add a Reminder")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            Spacer()
        }
        .onAppear(perform: {
            viewModel.getUpdatedMemories()
        })
        .sheet(item: $viewModel.sheetState) { sheetState in
            switch sheetState {
            case .audioRecording:
                AudioRecorderView()
            case .text:
                NoteWriterView(memoryStorage: viewModel.getMemoryStorage())
                    .onDisappear {
                        viewModel.getUpdatedMemories()
                    }
            }
        }
        .confirmationDialog("Select a Reminder Type", isPresented: $viewModel.showReminderOptions) {
            Button("Audio") {
                viewModel.sheetState = .audioRecording
            }
            
            Button("Text") {
                viewModel.sheetState = .text
            }
        }
        .loadingView(isLoading: $viewModel.isLoading)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(memoryStorage: MemoryStorage())
    }
}
