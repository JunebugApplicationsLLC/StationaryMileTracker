//
//  CalendarTrackerView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct CalendarTrackerView: View {
    @FocusState var isFocused: Bool
    @State var selectedDay: Day?
    @EnvironmentObject internal var trackedMileageViewModel: TrackedMileageViewModel
    
    private var milesForDay: Binding<Int> {
        Binding {
            guard let day = selectedDay else { return 0 }
            if let miles = trackedMileageViewModel.milesTrackedForDay[day] {
                return miles
            } else {
                return 0
            }
        } set: { updatedValue in
            guard let day = selectedDay else { return }
            trackedMileageViewModel.update(day: day, for: updatedValue)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                calendarView
                MilesChartView()
                    .frame(height: proxy.size.height * 0.4)
            }
        }
    }
    
    var calendarView: some View {
        CalendarProgressTracker(trackedMileageViewModel.highlightedDateViewModel) { date in
            selectedDay = date
        }
        .sheet(item: $selectedDay) { selectedDay in
            VStack {
                Text("\(selectedDay.name) \(selectedDay.date)")
                TextField("Miles", value: milesForDay, formatter: NumberFormatter())
                    .focused($isFocused)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

struct CalendarTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTrackerView()
            .environmentObject(TrackedMileageViewModel(highlightedDateViewModel: HighlightedDateViewModel(Calendar(identifier: .gregorian), TimeZone(identifier: "EST")!)))
    }
}
