//
//  Extensions.swift
//  Weatherly
//
//  Created by Esraa Ehab on 18/06/2026.
//

import Foundation
import SwiftUI

enum TimeOfDay {
    case morning
    case sunset
    case night
    
    var backgroundImageName: String {
        switch self {
        case .morning: return "morning"
        case .sunset: return "evining" 
        case .night: return "night"
        }
    }
    
    var textColor: Color {
        switch self {
        case .morning: return .black
        case .sunset, .night: return .white 
        }
    }
}

extension Date {
    var timeOfDay: TimeOfDay {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        
        let currentTime = Double(hour) + (Double(minute) / 60.0)
        
        if currentTime >= 5.0 && currentTime < 16.0 {
            return .morning   
        } else if currentTime >= 16.0 && currentTime < 19.5 {
            return .sunset    
        } else {
            return .night     
        }
    }
}



extension String {
    func toDayName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else { return self }
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else {
            formatter.dateFormat = "E"
            return formatter.string(from: date)
        }
    }
}


extension String {
    func toHourlyTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: self) else { return self }
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        let dateHour = Calendar.current.component(.hour, from: date)
        
        if Calendar.current.isDateInToday(date) && currentHour == dateHour {
            return "Now"
        }
        
        formatter.dateFormat = "ha"
        return formatter.string(from: date)
    }
}
