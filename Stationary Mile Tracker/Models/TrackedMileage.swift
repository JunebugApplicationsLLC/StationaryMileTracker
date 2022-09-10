//
//  TrackedMileage.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct TrackedMileage: Identifiable {
    var id: Day { day }
    var day: Day
    @Binding var miles: Int
}

extension TrackedMileage: Comparable {
    static func < (lhs: TrackedMileage, rhs: TrackedMileage) -> Bool {
        return lhs.day.date < rhs.day.date
    }
    
    static func == (lhs: TrackedMileage, rhs: TrackedMileage) -> Bool {
        return lhs.day.date == rhs.day.date
    }
}
