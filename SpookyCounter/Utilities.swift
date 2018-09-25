//
//  Utilities.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 9/22/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

func showTestData() {    
    for _ in 0..<7 {
        let trickOrTreater = TrickOrTreater(Date())
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<12 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 15))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<9 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 30))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<21 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 45))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<15 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 45))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<18 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 60))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<12 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 75))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<9 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 90))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
    for _ in 0..<3 {
        let trickOrTreater = TrickOrTreater(Date().addingTimeInterval(60 * 105))
        TrickOrTreatManager.shared.trickOrTreaters.append(trickOrTreater)
    }
}

func formattedTimeForDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm"
    return formatter.string(from: date)
}

func roundTimeToNearestQuarterHour(time: Date) -> Date {
    // Parameters
    let minuteGranuity = 15
    
    // Find current date and date components
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: time)
    let minute = calendar.component(.minute, from: time)
    
    // Round down to nearest date:
    let floorMinute = minute - (minute % minuteGranuity)
    let floorDate = calendar.date(bySettingHour: hour,
                                  minute: floorMinute,
                                  second: 0,
                                  of: time)!
    return floorDate
}
