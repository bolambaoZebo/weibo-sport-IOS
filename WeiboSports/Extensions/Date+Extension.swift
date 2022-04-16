//
//  Date+Extension.swift
//  WeiboSports
//
//  Created by 96group on 4/15/22.
//

import Foundation

extension Date {
    
    init?(value: String, format: String) {
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = format
        
        if let date = dtFormatter.date(from: value) {
            self = date
        } else {
            return nil
        }
    }
    
    init?(value: String, format: String, timeZone: TimeZone? = nil) {
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = format
        if let value = timeZone {
            dtFormatter.timeZone = value
        }
        
        if let date = dtFormatter.date(from: value) {
            self = date
        } else {
            return nil
        }
    }
    
    func to(format: String) -> String {
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = format
        
        return dtFormatter.string(from: self)
    }
    
    func to(format: String, timeZone: TimeZone) -> String {
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = format
        dtFormatter.timeZone = timeZone
        return dtFormatter.string(from: self)
    }
    
    func to(dateStyle: DateFormatter.Style, relativeFormatting: Bool = false, timeZone: TimeZone? = nil) -> String {
        let dtFormatter = DateFormatter()
        dtFormatter.dateStyle = dateStyle
        dtFormatter.doesRelativeDateFormatting = relativeFormatting
        if let value = timeZone {
            dtFormatter.timeZone = value
        }
        
        return dtFormatter.string(from: self)
    }
}
