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
    @ObservedObject var trackedMileageViewModel: TrackedMileageViewModel
    @State var goal: Int = 50

    var totalMilesTracked: Int {
        var trackedMiles = 0
        trackedMileageViewModel.milesTrackedForDay.forEach { day, miles in
            trackedMiles += miles
        }
        return trackedMiles
    }
    
    var trackedDays: [Day] {
        var days: [Day] = []
        let sortedTrackedDays = trackedMileageViewModel.milesTrackedForDay.keys.sorted { day1, day2 in
            day1 < day2
        }
        sortedTrackedDays.forEach { day in
            days.append(day)
        }
        return days
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    CalendarTrackerView(viewModel: trackedMileageViewModel)
                    milesTrendChart
                        .frame(height: proxy.size.height * 0.4)
                }
            }
            .navigationTitle("Monthly Mile Tracker")
        }
    }
    
    var goalButton: some View {
        Text("Goal: 500")
            .padding(8)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8.0)
    }
    
    var milesTrendChart: some View {
        VStack {
           goalButton
            if trackedDays.count < 2 {
                Spacer()
                Text("Log more miles to see trends over time")
                    .font(.caption).italic()
                Spacer()
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Miles Per Tracked Day")
                        .font(.subheadline)
                    Chart(trackedDays) { day in
                        LineMark(
                            x: PlottableValue.value("Date", "\(day.name) \(day.date)") ,
                            y: PlottableValue.value("Miles", trackedMileageViewModel.milesTrackedForDay[day] ?? 0)
                        )
                        .foregroundStyle(.pink)
                    }
                }
                .padding()
            }
            Text("Total Miles: \(totalMilesTracked)")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
