//
//  TrickOrTreatManager.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 10/31/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

// MARK: - Constants

let SpookyTrickOrTreaters = "SpookyTrickOrTreaters"
let SpookyStartTime = "SpookyStartTime"
let SpookyEndTime = "SpookyEndTime"

class TrickOrTreatManager {

    static let shared = TrickOrTreatManager()
    
    var trickOrTreaters = [TrickOrTreater]()
    var startTime: Date?
    var endTime: Date?
    
    var curCount: Int {
        get {
            return self.trickOrTreaters.count
        }
    }
    
    var dataDump: String {
        get {
            var result = ""
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            for curTreater in self.trickOrTreaters {
                result += "\(formatter.string(from: curTreater.timestamp))\n"
            }            
            return result
        }
    }
    
    init() {
        self.load()
    }
    
    func addTrickOrTreater() {
        let trickOrTreater = TrickOrTreater(roundTimeToNearestQuarterHour(time: Date()))
        self.trickOrTreaters.append(trickOrTreater)
        self.save()
    }
    
    func removeLastTrickOrTreater() {
        self.trickOrTreaters.removeLast()
        self.save()
    }
    
    func resetTrickOrTreaters() {
        self.trickOrTreaters.removeAll()
        self.startTime = nil
        self.endTime = nil
        self.save()
    }
    
    func load() {
        if let trickOrTreaterData = UserDefaults.standard.object(forKey: SpookyTrickOrTreaters) as? Data, let tempTrickOrTreaters = NSKeyedUnarchiver.unarchiveObject(with: trickOrTreaterData) as? [TrickOrTreater] {
            self.trickOrTreaters = tempTrickOrTreaters
        }
        if let tempStartTime = UserDefaults.standard.object(forKey: SpookyStartTime) as? Date {
            self.startTime = tempStartTime
        }
        if let tempEndTime = UserDefaults.standard.object(forKey: SpookyEndTime) as? Date {
            self.endTime = tempEndTime
        }
    }
    
    func save() {
        let trickOrTreaterData = NSKeyedArchiver.archivedData(withRootObject: self.trickOrTreaters)
        UserDefaults.standard.set(trickOrTreaterData, forKey: SpookyTrickOrTreaters)
        UserDefaults.standard.set(self.startTime, forKey: SpookyStartTime)
        UserDefaults.standard.set(self.endTime, forKey: SpookyEndTime)
        UserDefaults.standard.synchronize()
    }
    
    func trickOrTreatersBetweenTime(startTime: Date, endTime: Date) -> [TrickOrTreater] {
        var result = [TrickOrTreater]()
        
        for curTreater in self.trickOrTreaters {
            if curTreater.timestamp.dateWithoutSeconds().isBetweenDatesInclusive(startTime, endDate: endTime) {
                result.append(curTreater)
            }
        }
        
        return result
    }
    
}
