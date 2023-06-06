//
//  AudioRecorderService.swift
//  Assistant
//
//  Created by Vince Carlo Santos on 6/5/23.
//

import Foundation
import AVFoundation

class AudioRecorderService: NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var soundRecorder: AVAudioRecorder!
    var soundPlayer: AVAudioPlayer = AVAudioPlayer()
    var audioSession: AVAudioSession = AVAudioSession()
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var mixer: AVAudioMixerNode = AVAudioMixerNode()
    var fileName = "101.m4a"
    var isRecording = false
    
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
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
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
        isRecording = true
    }
    
    public func stopRecording() {
        soundRecorder.stop()
        isRecording = false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AudioRecorderService: Ended Recording")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("AudioRecorderService: Audio Stopped Playing")
    }
}
