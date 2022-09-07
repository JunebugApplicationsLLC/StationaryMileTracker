//
//  ContentView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct ContentView: View {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.timeZone) var timeZone: TimeZone
    @ObservedObject var trackedMileageViewModel = TrackedMileageViewModel()
    var body: some View {
        VStack {
            CalendarTrackerView(viewModel: trackedMileageViewModel)
            List {
                ForEach(Array(trackedMileageViewModel.milesTrackedForDay.keys), id: \.self) { key in
                    Text("\(key.monthName) \(key.name) \(key.date): \(trackedMileageViewModel.milesTrackedForDay[key] ?? 0) miles")
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
