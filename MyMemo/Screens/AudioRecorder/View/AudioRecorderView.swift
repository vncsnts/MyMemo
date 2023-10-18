//
//  AudioRecorderView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 6/5/23.
//

import SwiftUI

struct AudioRecorderView: View {
    @EnvironmentObject var memoryStorage: MemoryStorage
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AudioRecorderViewModel()

    var body: some View {
        VStack {
            HStack {
                TextField("Enter a title...", text: $viewModel.title)
                    .font(.headline)
                Spacer()
                Button("Save") {
                    dismiss()
                }
            }
            .padding()
            VStack {
                WaveView()
                HStack {
                    Button(action: {
                        viewModel.isRecording.toggle()
                    }, label: {
                        ZStack {
                            if viewModel.isRecording {
                                Rectangle()
                                    .foregroundColor(.red)
                                    .padding(10)
                            } else {
                                Circle()
                                    .foregroundColor(.red)
                                    .padding(10)
                            }
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                        }
                    })
                    .frame(width: 44, height: 44, alignment: .center)
                    
                    Button(action: {
                        viewModel.isPlaying.toggle()
                    }, label: {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                    })
                    .frame(width: 44, height: 44, alignment: .center)
                    .disabled(!viewModel.hasRecordedData)
                    
                    Button("Save") {
                        viewModel.saveRecordedAudio(memoryStorage: memoryStorage)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.hasRecordedData)
                }
            }
        }
        .onAppear {
            viewModel.initializeRecorder()
        }
        .presentationDetents([.fraction( 0.25)])
    }
}

struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}
