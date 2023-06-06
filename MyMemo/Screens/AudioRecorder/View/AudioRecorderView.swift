//
//  AudioRecorderView.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 6/5/23.
//

import SwiftUI

struct AudioRecorderView: View {
    @StateObject var viewModel = AudioRecorderViewModel()

    var body: some View {
        VStack {
            Spacer()
            if viewModel.isRecording {
                WaveView()
            }
            HStack {
                Button(action: {
                    viewModel.isRecording.toggle()
                }, label: {
                    if viewModel.isRecording {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.red)
                                .padding(10)
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                        }
                    } else {
                        ZStack {
                            Circle()
                                .foregroundColor(.red)
                                .padding(4)
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                        }
                    }
                })
                .animation(.linear, value: viewModel.isRecording)
                .frame(width: 44, height: 44, alignment: .center)
                
                Button(action: {
                    viewModel.isPlaying.toggle()
                }, label: {
                    if viewModel.isPlaying {
                        Image(systemName: "pause.fill")
                    } else {
                        Image(systemName: "play.fill")
                    }
                })
                .frame(width: 44, height: 44, alignment: .center)
            }
        }
        .onAppear {
            viewModel.initializeRecorder()
        }
        .presentationDetents([.fraction( viewModel.isRecording ? 0.25 : 0.1)])
    }
}

struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}
