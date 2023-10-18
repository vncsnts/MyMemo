//
//  HomeView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 5/24/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    @State var isAnimating = false
    
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
                    .scaleEffect(isAnimating ? 1 : 0)
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
        .opacity(isAnimating ? 1 : 0)
        .animation(.easeIn(duration: 1), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(memoryStorage: MemoryStorage())
    }
}
