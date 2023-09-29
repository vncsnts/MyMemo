//
//  AudioRecorderService.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 6/5/23.
//

import Foundation
import AVFoundation

protocol AudioRecorderProtocol {
    var audioStoppedPlaying: (() -> Void)? { get set }
    var recordingDone: ((URL) -> Void)? { get set }
}

class AudioRecorderService: NSObject, AudioRecorderProtocol {
    var audioStoppedPlaying: (() -> Void)?
    var recordingDone: ((URL) -> Void)?
    
    private var soundRecorder: AVAudioRecorder!
    private var soundPlayer: AVAudioPlayer = AVAudioPlayer()
    private var audioSession: AVAudioSession = AVAudioSession()
    private var audioEngine: AVAudioEngine = AVAudioEngine()
    private var mixer: AVAudioMixerNode = AVAudioMixerNode()
    private var fileName = ""
    private var currentUrl: URL?
    
    override init() {
        do {
            try audioSession.setCategory(.multiRoute, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("AudioRecorderService: \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public func initializeRecorder() {
        self.fileName = "\(UUID().uuidString).m4a"
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        self.currentUrl = audioFileName
        let recordSetting = [AVFormatIDKey: kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey: 32000,
                             AVNumberOfChannelsKey: 2,
        AVSampleRateKey: 44100.0] as [String: Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    public func playAudio() {
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
            soundPlayer.play()
            print("AudioRecorderService: Playing Audio \(audioFileName)")
        } catch {
            print("AudioRecorderService: \(error.localizedDescription)")
        }
    }
    
    public func pauseAudio() {
        soundPlayer.pause()
    }
    
    public func startRecording() {
        soundRecorder.record()
    }
    
    public func stopRecording() {
        soundRecorder.stop()
    }
}

extension AudioRecorderService: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AudioRecorderService: Ended Recording")
        guard let currentUrl = self.currentUrl else { return }
        self.recordingDone?(currentUrl)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("AudioRecorderService: Audio Stopped Playing")
        self.audioStoppedPlaying?()
    }
}
