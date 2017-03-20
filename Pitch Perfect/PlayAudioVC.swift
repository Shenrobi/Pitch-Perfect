//
//  PlayAudioVC.swift
//  Pitch Perfect
//
//  Created by Terrell Robinson on 2/19/17.
//  Copyright © 2017 FlyGoody. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Properties
    
    var receivedAudioURL: RecordedAudio!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: Enum
    
    enum ButtonType: Int {
        case Slow = 0,
        Fast,
        Chipmunk,
        Vader,
        Echo,
        Reverb
    }

    // MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI(playState: .NotPlaying)
        
        // Selectors for Interruptions, Route Changes and Calls
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioInterrupt(notification:)), name: NSNotification.Name.AVAudioSessionInterruption, object: AVAudioSession.sharedInstance())
        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioInterrupt(notification:)), name: NSNotification.Name.AVAudioSessionRouteChange, object: AVAudioSession.sharedInstance())
        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioInterrupt(notification:)), name: NSNotification.Name.AVAudioSessionMediaServicesWereReset, object: AVAudioSession.sharedInstance())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop Audio Function is called so the audio does not keep playing on the RecordAudioVC when the user clicked the back button
        
        stopAudio()
        audioEngine = nil
        stopTimer = nil
        audioPlayerNode = nil
        
        //Remove selectors for Interruptions, Route Changes and Calls
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVAudioSessionInterruption, object: AVAudioSession.sharedInstance())
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVAudioSessionRouteChange, object: AVAudioSession.sharedInstance())
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVAudioSessionMediaServicesWereReset, object: AVAudioSession.sharedInstance())
        
    }

    // MARK: IBActions

    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Sound is playing")
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(playState: .Playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    // MARK: Notification Selectors
    
    func handleAudioInterrupt(notification: NSNotification) {
        
        if let interruptionValue = (notification.userInfo)?["AVAudioSessionInterruptionTypeKey"] as? NSNumber {
            if let interruptionType = AVAudioSessionInterruptionType(rawValue: interruptionValue.uintValue) {
                switch interruptionType {
                case .began:
                    stopAudio()
                default:
                    break
                }
            }
        }
        
    }
    
    func handleAudioRouteChange(notification: NSNotification) {
        
        if let changeValue = (notification.userInfo)?["AVAudioSessionRouteChangeReasonKey"] as? NSNumber {
            if let changeType = AVAudioSessionRouteChangeReason(rawValue: changeValue.uintValue) {
                switch changeType {
                case .oldDeviceUnavailable, .newDeviceAvailable:
                    stopAudio()
                default:
                    break
                }
            }
        }
        
    }
    
    func handleAudioMediaSeviceReset(notification: NSNotification) {
        
        setupAudio()
        stopAudio()
    }
    
    
}
