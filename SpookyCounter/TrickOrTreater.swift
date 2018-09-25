//
//  TrickOrTreater.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 10/31/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

class TrickOrTreater: NSObject, NSCoding {

    var timestamp = Date()
    
    init(_ date: Date) {
        self.timestamp = date
    }
    
    required init?(coder decoder: NSCoder)
    {
        if let data = decoder.decodeObject(forKey: "TrickOrTreaterTimestamp") as? Data, let tempTimestamp = NSKeyedUnarchiver.unarchiveObject(with: data) as? Date {
            self.timestamp = tempTimestamp
        }
    }
    
    func encode(with coder: NSCoder)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: self.timestamp)
        coder.encode(data, forKey: "TrickOrTreaterTimestamp")
    }
    
}
