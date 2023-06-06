//
//  AudioRecorderViewModel.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 6/5/23.
//

import Foundation

@MainActor
final class AudioRecorderViewModel: ObservableObject {
    private var audioRecorderService = AudioRecorderService()
    
    @Published var isRecording = false {
        didSet {
            if isRecording {
                startRecordingAudio()
            } else {
                stopRecordingAudio()
            }
        }
    }
    
    @Published var isPlaying = false {
        didSet {
            if isPlaying {
                playLastRecordedAudio()
            } else {
                pauseLastRecordedAudio()
            }
        }
    }
    
    func initializeRecorder() {
        audioRecorderService.initializeRecorder()
    }
    
    func startRecordingAudio() {
        audioRecorderService.startRecording()
    }
    
    func stopRecordingAudio() {
        audioRecorderService.stopRecording()
    }
    
    func playLastRecordedAudio() {
        audioRecorderService.playAudio()
    }
    
    func pauseLastRecordedAudio() {
        audioRecorderService.pauseAudio()
    }
}
