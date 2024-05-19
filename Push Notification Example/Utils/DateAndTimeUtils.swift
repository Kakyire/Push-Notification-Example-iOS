//
//  DateAndTimeUtils.swift
//  Push Notification Example
//
//  Created by Daniel Frimpong on 14/05/2024.
//

import Foundation

struct DateAndTimeUtils{
    
    private static var dateFormatter = DateFormatter()
    private static let dateFormat = "dd MMMM, yyyy"
    //    "2023-10-17T13:38:00Z"
    //    "2024-04-04T12:57:59"
    //12 May 2024 at 08:32:44 UTC

    static func formatDate( from input:String, to:String = "dd MMMM, yyyy") -> String{
        
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let date = dateFormatter.date(from:input)
        
        let timeFormat = is12HourFormat() ? " - hh:mm a" : " - HH:mm"
        
        
        dateFormatter.dateFormat = to + timeFormat
        
        let output :String
        if date != nil {
            output = dateFormatter.string(from: date!)
        }else{
            output = input
        }
        return output
    }
    
    static func formatDate(from input:Date?) -> String{
        
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
//        let date = dateFormatter.string(from: <#T##Date#>)
        
        let timeFormat = is12HourFormat() ? "hh:mm a" : "HH:mm"
        
        
        dateFormatter.dateFormat =  dateFormat
        
        let output :String
        if input != nil {
            output = dateFormatter.string(from: input!)
        }else{
            output = ""
        }
        return output
    }
   
    static func formatTime(from input:Date?) -> String{
        
        let  dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
//        let date = dateFormatter.string(from: <#T##Date#>)
        
        let timeFormat = is12HourFormat() ? "hh:mm a" : "HH:mm"
        
        
        dateFormatter.dateFormat =  timeFormat
        
        let output :String
        if input != nil {
            output = dateFormatter.string(from: input!)
        }else{
            output = ""
        }
        return output
    }
    
   static func formattedDateString(from date: Date,includeMinAgo:Bool = false) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let dateComponents = calendar.dateComponents([.minute,.hour,], from: date, to: now)
        
        if includeMinAgo{
            
            if let minutes = dateComponents.minute, minutes < 60 {
                return "\(minutes)m ago"
            }
            
            if let hours = dateComponents.hour, hours < 24 {
                return "\(hours)h ago"
            }
        }
        
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // Day of the week
            return dateFormatter.string(from: date)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM, yyyy"
            return dateFormatter.string(from: date)
        }
    }
   static func formattedDateString(from input: String,includeMinAgo:Bool = false) -> String {
        let calendar = Calendar.current
        let now = Date()
       
       let  dateFormatter = DateFormatter()
       dateFormatter.dateFormat = dateFormat
       
       let date = dateFormatter.date(from:input) ?? Date()
        
        let dateComponents = calendar.dateComponents([.minute,.hour,], from: date, to: now)
        
        if includeMinAgo{
            
            if let minutes = dateComponents.minute, minutes < 60 {
                return "\(minutes)m ago"
            }
            
            if let hours = dateComponents.hour, hours < 24 {
                return "\(hours)h ago"
            }
        }
        
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // Day of the week
            return dateFormatter.string(from: date)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM, yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
    private static func is12HourFormat() -> Bool {
        DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)?.range(of: "a") != nil
    }
}
