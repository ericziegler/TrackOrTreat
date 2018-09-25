//
//  SoundManager.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 10/27/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

class SoundManager {

    var soundIsOff: Bool = true
    
    static let defaultManager = SoundManager()
    
    init() {
        self.loadSoundStatus()
    }
    
    func toggleSoundStatus() {
        self.soundIsOff = !self.soundIsOff
        self.saveSoundStatus()
    }
    
    func loadSoundStatus() {
        self.soundIsOff = UserDefaults.standard.bool(forKey: "SpookySound")
    }
    
    func saveSoundStatus() {
        UserDefaults.standard.set(self.soundIsOff, forKey: "SpookySound")
        UserDefaults.standard.synchronize()
    }
    
}
