//
//  PlayViewController.swift
//  PitchPerfectFilipi
//
//  Created by Filipi Brentegani on 09/09/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    // MARK: Variables and Constants
    let defaultPitchValue: Float = 0.0
    let defaultRateValue: Float = 1.0
    let defaultEchoReverbValue = false
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var screenState: PlayingState = .notPlaying
    
    // MARK: Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var echoSwitch: UISwitch!
    @IBOutlet weak var reverbSwitch: UISwitch!
    
    
    // MARK: IBActions
    @IBAction func onPlayStopPressed(_ sender: Any) {
        if screenState == PlayingState.playing {
            stopAudio()
        } else {
            playSound(rate: rateSlider.value, pitch: pitchSlider.value, echo: echoSwitch.isOn, reverb: reverbSwitch.isOn)
            configureUI(.playing)
        }
    }
    
    @IBAction func onResetPressed(_ sender: Any) {
        if screenState == PlayingState.playing {
            stopAudio()
        }
        rateSlider.value = defaultRateValue
        pitchSlider.value = defaultPitchValue
        echoSwitch.isOn = defaultEchoReverbValue
        reverbSwitch.isOn = defaultEchoReverbValue
    }
}
