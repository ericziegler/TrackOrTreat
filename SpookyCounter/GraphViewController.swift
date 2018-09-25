//
//  GraphViewController.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 10/31/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit
import MessageUI

let GraphTimeInterval: TimeInterval = 60 * 15

class GraphViewController: UIViewController {
    
    @IBOutlet var graphContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGraph()
    }
    
    private func setupGraph() {
        let timeData = self.retrieveTimestamps()
        let graph = GraphView(frame: CGRect.zero, data: timeData)
        graph.translatesAutoresizingMaskIntoConstraints = false
        self.graphContainer.addSubview(graph)
        self.graphContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view" : graph]))
        self.graphContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view" : graph]))
    }
    
    private func retrieveTimestamps() -> NSArray {
        var times = [[String : Any]] ()
        var count = 0
        let manager = TrickOrTreatManager.shared
        if var startTime = manager.startTime, let endTime = manager.endTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm"
            let numberOfIntervals = Int((endTime.timeIntervalSince1970 - startTime.timeIntervalSince1970) / 60 / 15)
            for _ in 0..<numberOfIntervals {
                count = manager.trickOrTreatersBetweenTime(startTime: startTime.addingTimeInterval(-60.0 * 15.0), endTime: startTime).count
                times.append(["label" : formatter.string(from: startTime), "value" : NSNumber(integerLiteral: count)])
                startTime = startTime.addingTimeInterval(GraphTimeInterval + 1.0)
            }
        }
        
        return times as NSArray
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func closeTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exportTapped(_ sender: AnyObject) {
        self.export()
    }
    
    private func export() {
        var recipients = [String]()
        let alert = UIAlertController(title: "Email", message: "Who would you like this data emailed to?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            if let text = textField.text {
                recipients = [text]
            }
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if MFMailComposeViewController.canSendMail() {
                let composeViewController = MFMailComposeViewController()
                composeViewController.setSubject("Track or Treat Data")
                composeViewController.setMessageBody(TrickOrTreatManager.shared.dataDump, isHTML: false)
                composeViewController.setToRecipients(recipients)
                composeViewController.mailComposeDelegate = self
                self.present(composeViewController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Export Unavailable", message: "This device cannot send emails.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension GraphViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
