//
//  Stationary_Mile_TrackerApp.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import SwiftUI
import CalendarProgressTracker

@main
struct Stationary_Mile_TrackerApp: App {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.timeZone) var timeZone: TimeZone
    
    var body: some Scene {
        WindowGroup {
            ContentView(trackedMileageViewModel: TrackedMileageViewModel(highlightedDateViewModel: HighlightedDateViewModel(monthViewModel: MonthViewModel(calendar: calendar, timeZone: timeZone))))
        }
    }
}
