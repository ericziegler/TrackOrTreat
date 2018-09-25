//
//  Extensions.swift
//  SpookyCounter
//
//  Created by Eric Ziegler on 10/31/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

extension NSDate {

    func isBetweenDatesInclusive(_ startDate: NSDate, endDate: NSDate) -> Bool
    {
        return (self as Date).isBetweenDatesInclusive(startDate as Date, endDate: endDate as Date)
    }
    
}

extension Date {

    func isEarlierThan(_ date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    func isLaterThan(_ date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    func isBetweenDates(_ startDate: Date, endDate: Date) -> Bool {
        if (self.isEarlierThan(startDate)) {
            return false
        }
        if (self.isLaterThan(endDate)) {
            return false
        }
        return true
    }
    
    func isBetweenDatesInclusive(_ startDate: Date, endDate: Date) -> Bool
    {
        var result = self.isBetweenDates(startDate, endDate: endDate)
        if (!result)
        {
            if ((self == startDate) || (self == endDate))
            {
                result = true
            }
        }
        return result
    }
    
    func dateWithoutSeconds() -> Date {
        var result = self
        let timeInterval = floor(self.timeIntervalSinceReferenceDate / 60.0) * 60.0
        result = Date(timeIntervalSinceReferenceDate: timeInterval)
        return result
    }
    
}

extension UIImage {
    
    func maskedImageWithColor(_ color: UIColor) -> UIImage? {
        var result: UIImage?
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        if let context: CGContext = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            
            // flip coordinate system or else CGContextClipToMask will appear upside down
            context.translateBy(x: 0, y: rect.size.height);
            context.scaleBy(x: 1.0, y: -1.0);
            
            // mask and fill
            context.setFillColor(color.cgColor)
            context.clip(to: rect, mask: cgImage);
            context.fill(rect)
            
        }
        
        result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
}

extension UIColor {

    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 08) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 00) / 255.0
        self.init(red:r, green:g, blue:b, alpha:alpha)
    }
    
    convenience init(integerRed red: Int, green: Int, blue: Int, alpha: Int = 255) {
        let r = CGFloat(red) / 255.0
        let g = CGFloat(green) / 255.0
        let b = CGFloat(blue) / 255.0
        let a = CGFloat(alpha) / 255.0
        self.init(red:r, green:g, blue:b, alpha:a)
    }
    
    var iconColor: UIColor {
        get {
            return UIColor(hex: 0xFF8000)
        }
    }
    
}
