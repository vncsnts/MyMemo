//
//  AudioRecorderViewModel.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 6/5/23.
//

import Foundation

extension AudioRecorderView {
    @MainActor
    final class AudioRecorderViewModel: ObservableObject {
        private var audioRecorderService = AudioRecorderService()
        
        @Published var isRecording = false {
            didSet {
                if self.isRecording {
                    self.startRecordingAudio()
                } else {
                    self.stopRecordingAudio()
                }
            }
        }
        
        @Published var isPlaying = false {
            didSet {
                if self.isPlaying {
                    self.playLastRecordedAudio()
                } else {
                    self.pauseLastRecordedAudio()
                }
            }
        }
        
        @Published var hasRecordedData = false
        @Published var currentUrl: URL?
        @Published var currentName: String?
        
        func setListeners() {
            self.audioRecorderService.audioStoppedPlaying = { [self] in
                self.isPlaying = false
            }
            
            self.audioRecorderService.recordingDone = { url in
                self.hasRecordedData = true
                self.currentUrl = url
                self.currentName = UUID().uuidString
            }
        }
        
        func initializeRecorder() {
            self.setListeners()
            self.audioRecorderService.initializeRecorder()
        }
        
        func startRecordingAudio() {
            self.audioRecorderService.startRecording()
        }
        
        func stopRecordingAudio() {
            self.audioRecorderService.stopRecording()
        }
        
        func playLastRecordedAudio() {
            self.audioRecorderService.playAudio()
        }
        
        func pauseLastRecordedAudio() {
            self.audioRecorderService.pauseAudio()
        }
        
        func saveRecordedAudio(memoryStorage: MemoryStorage) {
            guard let currentUrl = currentUrl, let currentName = currentName else { return }
        }
    }
}
