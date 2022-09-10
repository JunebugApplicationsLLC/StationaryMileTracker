//
//  TrackedMileageViewModel.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import Foundation
import SwiftUI

class TrackedMileageViewModel: ObservableObject {
    @Published var milesTrackedForDay: [Day: Int] = [:]
    @ObservedObject var highlightedDateViewModel: HighlightedDateViewModel
    
    var totalMilesTracked: Int {
        var trackedMiles = 0
        milesTrackedForDay.forEach { day, miles in
            trackedMiles += miles
        }
        return trackedMiles
    }
    
    var trackedDays: [Day] {
        var days: [Day] = []
        let sortedTrackedDays = milesTrackedForDay.keys.sorted { day1, day2 in
            day1 < day2
        }
        sortedTrackedDays.forEach { day in
            days.append(day)
        }
        return days
    }
    
    init(milesTrackedForDay: [Day : Int] = [:], highlightedDateViewModel: HighlightedDateViewModel) {
        self.milesTrackedForDay = milesTrackedForDay
        self.highlightedDateViewModel = highlightedDateViewModel
    }
    
    func update(day: Day, for miles: Int) {
        var highlightedDay = day
        highlightedDay.should(highlightDay: true)
       
        if let observableDayIndex = highlightedDateViewModel.days.observableDays.firstIndex(of: highlightedDay) {
            _ = highlightedDateViewModel.days.observableDays.remove(at: observableDayIndex)
            highlightedDateViewModel.days.observableDays.insert(highlightedDay, at: observableDayIndex)
            milesTrackedForDay[highlightedDay] = miles
        }
    }
}
