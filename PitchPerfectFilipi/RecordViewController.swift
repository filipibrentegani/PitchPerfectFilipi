//
//  ViewController.swift
//  PitchPerfectFilipi
//
//  Created by Filipi Brentegani on 05/09/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    // MARK: Variables
    var audioRecorder: AVAudioRecorder!

    // MARK: IBOutlets
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    // MARK: Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIBehavior("Tap to record!", false)
    }

    // MARK: IBActions
    @IBAction func onRecordButtonPressed(_ sender: Any) {
        setupUIBehavior("Recording...", true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func onStopButtonPressed(_ sender: Any) {
        setupUIBehavior("Tap to record!", false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func setupUIBehavior(_ recordingMessage: String, _ isRecording: Bool) {
        recordLabel.text = recordingMessage
        stopButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
    }
}

// MARK: Extensions
extension RecordViewController : AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "showPlayScreen", sender: audioRecorder.url)
        }else{
            print("error while recording...")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayScreen" {
            let playVC = segue.destination as! PlayViewController
            let recordedAudioURL = sender as! URL
            playVC.recordedAudioURL = recordedAudioURL
        }
    }
}

