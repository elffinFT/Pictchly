//
//  ViewController.swift
//  Pitchly
//
//  Created by elffinft on 10/04/2019.
//  Copyright © 2019 Silindrin. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

	var audioRecorder: AVAudioRecorder!
	
	// MARK: Outlets
	
	@IBOutlet weak var recordingLabel: UILabel!
	@IBOutlet weak var recordAudioButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!
	
	// MARK: App lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	// MARK: Actions
	
	@IBAction func recordAudio(_ sender: UIButton) {
		updateUIButtonStatus()
		
		// Start recording audio
		let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
		let recordingName = "recordedVoice.wav"
		let pathArray = [dirPath, recordingName]
		let filePath = URL(string: pathArray.joined(separator: "/"))
		
		let session = AVAudioSession.sharedInstance()
		try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
		
		try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
		audioRecorder.delegate = self
		audioRecorder.isMeteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record()
	}
	
	@IBAction func stopRecording(_ sender: UIButton) {
		updateUIButtonStatus()
		
		// Stop recording audio
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
	}
	
	// Update UI buttons
	fileprivate func updateUIButtonStatus() {
		if !stopRecordingButton.isEnabled {
			recordingLabel.text = "Recording in Progress"
			recordAudioButton.isEnabled = false
			stopRecordingButton.isEnabled = true
		} else {
			recordingLabel.text = "Tap to Record"
			recordAudioButton.isEnabled = true
			stopRecordingButton.isEnabled = false
		}
	}
	
	// MARK: Segue to SoundEffextsController
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
		performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
		} else {
			print("Recording was not successful")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecording" {
			let soundEffectsVC = segue.destination as! SoundEffectsViewController
			let recordedAudioURL = sender as! URL
			soundEffectsVC.recordedAudioURL = recordedAudioURL
		}
	}
}
