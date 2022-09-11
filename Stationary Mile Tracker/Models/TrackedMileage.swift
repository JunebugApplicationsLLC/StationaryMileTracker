//
//  TrackedMileage.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct TrackedDay: Identifiable {
    var id: Day { day }
    var day: Day
    var miles: Int
}

extension TrackedDay: Comparable {
    static func < (lhs: TrackedDay, rhs: TrackedDay) -> Bool {
        return lhs.day.date < rhs.day.date
    }
    
    static func == (lhs: TrackedDay, rhs: TrackedDay) -> Bool {
        return lhs.day.date == rhs.day.date
    }
}
