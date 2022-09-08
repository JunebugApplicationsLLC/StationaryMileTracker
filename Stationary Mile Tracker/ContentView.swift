//
//  ContentView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI
import Charts

struct ContentView: View {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.timeZone) var timeZone: TimeZone
    @ObservedObject var trackedMileageViewModel = TrackedMileageViewModel()
    @State var goal: Int = 50
    var totalMilesTracked: Int {
        var trackedMiles = 0
        trackedMileageViewModel.milesTrackedForDay.forEach { day, miles in
            trackedMiles += miles
        }
        return trackedMiles
    }
    var body: some View {
        VStack {
            CalendarTrackerView(viewModel: trackedMileageViewModel)
            Chart(Array(trackedMileageViewModel.milesTrackedForDay.keys)) { key in
                LineMark(
                    x: PlottableValue.value("Date", "\(key.name) \(key.date)") ,
                    y: PlottableValue.value("Miles", trackedMileageViewModel.milesTrackedForDay[key] ?? 0)
                )
            }
            .padding()
            Text("Total Miles: \(totalMilesTracked)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
