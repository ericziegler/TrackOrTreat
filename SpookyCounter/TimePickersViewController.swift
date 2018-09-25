//
//  TimePickersViewController.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 9/24/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: - Constants

let TimePickersViewControllerId = "TimePickersViewControllerId"

class TimePickersViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var startTimePicker: UIDatePicker!
    @IBOutlet var endTimePicker: UIDatePicker!
    
    // MARK: - Init
    
    class func createController() -> TimePickersViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: TimePickersViewController = storyboard.instantiateViewController(withIdentifier: TimePickersViewControllerId) as! TimePickersViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimePicker.setValue(UIColor.white, forKey: "textColor")
        endTimePicker.setValue(UIColor.white, forKey: "textColor")
        let startTime = startTimePicker.date
        endTimePicker.date = startTime.addingTimeInterval(60 * 60 * 2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @IBAction func closeTapped(_ sender: AnyObject) {
        TrickOrTreatManager.shared.startTime = roundTimeToNearestQuarterHour(time: startTimePicker.date)
        TrickOrTreatManager.shared.endTime = roundTimeToNearestQuarterHour(time: endTimePicker.date)
        TrickOrTreatManager.shared.save()
        self.dismiss(animated: true, completion: nil)
    }
    
}
