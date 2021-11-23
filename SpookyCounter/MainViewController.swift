//
//  MainViewController.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 10/25/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var peopleLabel: UILabel!
    @IBOutlet var treatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTreatButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if TrickOrTreatManager.shared.startTime == nil || TrickOrTreatManager.shared.endTime ==  nil {
            let timePickerVC = TimePickersViewController.createController()
            self.present(timePickerVC, animated: true, completion: nil)
        }
        self.updateCount()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupTreatButton() {
        let layer = treatButton.layer
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.5
        layer.cornerRadius = 8
    }
    
    @IBAction func addToCount(_ sender: AnyObject) {
        self.playClickSound()
        TrickOrTreatManager.shared.addTrickOrTreater()
        self.updateCount()
    }
    
    @IBAction func optionsTapped(_ sender: AnyObject) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // sound
        let soundOption = (SoundManager.defaultManager.soundIsOff == true) ? "Turn Sound On" : "Turn Sound Off"
        let soundAction = UIAlertAction(title: soundOption, style: .default) { (action) in
            SoundManager.defaultManager.toggleSoundStatus()
        }
        
        // undo
        let undoAction = UIAlertAction(title: "Undo Last Treat", style: .default) { (action) in
            TrickOrTreatManager.shared.removeLastTrickOrTreater()
            self.updateCount()
        }
        
        // reset
        let resetAction = UIAlertAction(title: "Reset", style: .default) { (action) in
            self.resetCount()
        }
        actionSheet.addAction(soundAction)
        actionSheet.addAction(undoAction)
        actionSheet.addAction(resetAction)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func resetCount() {
        let alert = UIAlertController(title: "Reset Trick or Treat Count?", message: "Are you sure you would like to reset the count back to zero?", preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.destructive) { (_) in
            TrickOrTreatManager.shared.resetTrickOrTreaters()
            let timePickersController = TimePickersViewController.createController()
            self.present(timePickersController, animated: true, completion: nil)
            self.updateCount()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(resetAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateCount() {
        self.countLabel.text = "\(TrickOrTreatManager.shared.curCount)"
        
        if TrickOrTreatManager.shared.curCount == 1 {
            self.peopleLabel.text = "Trick or Treater"
        } else {
            self.peopleLabel.text = "Trick or Treaters"
        }
    }
    
    private func playClickSound() {
        if SoundManager.defaultManager.soundIsOff == false, let url = Bundle.main.url(forResource: "click", withExtension: "wav") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
            AudioServicesPlayAlertSound(soundId)
        }
        AudioServicesPlayAlertSound(UInt32(kSystemSoundID_Vibrate))
    }
    
}

