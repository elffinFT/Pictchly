//
//  EditingViewController.swift
//  Pitchly
//
//  Created by elffinft on 10/04/2019.
//  Copyright © 2019 Silindrin. All rights reserved.
//

import UIKit
import AVFoundation

class SoundEffectsViewController: UIViewController  {

	var recordedAudioURL: URL!
	var audioFile: AVAudioFile!
	var audioEngine: AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!
	
	enum ButtonType: Int {
		case snail = 0, rabbit, chipmunk, vader, echo, reverb
	}
	
	// MARK: Outlets
	
	@IBOutlet weak var snailButton: UIButton!
	@IBOutlet weak var chipmunkButton: UIButton!
	@IBOutlet weak var rabbitButton: UIButton!
	@IBOutlet weak var vaderButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	// MARK: App lifecycle
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setupAudio()
		removeTextFromBackButton()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureUI(.notPlaying)
	}
	
	// Remove text from nav bar back button
	fileprivate func removeTextFromBackButton() {
		if let topItem = self.navigationController?.navigationBar.topItem {
			topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
		}
	}
	
	// MARK: Actions
	
	@IBAction func playSoundFXFPressed(_ sender: UIButton)
	{
		switch (ButtonType(rawValue: sender.tag)!) {
		case .snail:
			playSound(rate: 0.5)
		case .rabbit:
			playSound(rate: 1.5)
		case .chipmunk:
			playSound(pitch: 1000)
		case .vader:
			playSound(pitch: -1000)
		case .echo:
			playSound(echo: true)
		case .reverb:
			playSound(reverb: true)
		}
		configureUI(.playing)
	}
	
	@IBAction func stopButtonPressed(_ sender: AnyObject) {
		stopAudio()
	}

}
