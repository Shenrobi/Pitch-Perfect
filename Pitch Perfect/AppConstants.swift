//
//  AppConstants.swift
//  Pitch Perfect
//
//  Created by Terrell Robinson on 2/19/17.
//  Copyright © 2017 FlyGoody. All rights reserved.
//

import Foundation

struct AppConstants {
    
    static let audioFileName = "recordedVoice.wav"
    static let stopRecordingSegueIdentifier = "stopRecording"
    
    struct labels {
        
         static let Recording = "Recording..."
         static let ReadyToRecord = "Tap to Record"
    }
    
    struct alerts {
        
        static let dismiss = "Dismiss"
        static let recordingAudioError = "Audio Recording Error"
        static let recordingUnsuccessful = "Recording Unsuccessful"
        static let recordingUnsuccessfulMessage = "Something went wrong with your recording."
        static let audioSessionError = "Audio Session Error"
        static let audioRecorderError = "Audio Recorder Error"
        static let recordingDisabledTitle = "Recording Disabled"
        static let recordingDisabledMessage = "You've disabled Pitch Perfect from recording your microphone. Check your settings."
        static let audioFileError = "Audio File Error"
        static let audioEngineError = "Audio Engine Error"
    }
    
}

