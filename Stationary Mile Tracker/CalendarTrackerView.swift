//
//  CalendarTrackerView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct CalendarTrackerView: View {
    @State var dateIsHighlighted = false
    @FocusState var isFocused: Bool
    @State var selectedDay: Day?
    @ObservedObject internal var trackedMileageViewModel: TrackedMileageViewModel
    
    private var milesForDay: Binding<Int> {
        Binding {
            guard let day = selectedDay else { return 0 }
            if let miles = trackedMileageViewModel.milesTrackedForDay[day] {
                return miles
            } else {
                return 0
            }
        } set: { updatedValue in
            guard let day = selectedDay,
            updatedValue > 0 else { return }
            trackedMileageViewModel.update(day: day, for: updatedValue)
        }
    }
    
    init(viewModel: TrackedMileageViewModel) {
        trackedMileageViewModel = viewModel
    }
    
    var body: some View {
        CalendarProgressTracker(monthViewModel: trackedMileageViewModel.highlightedDateViewModel.monthViewModel) { date in
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

//struct CalendarTrackerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarTrackerView(viewModel: TrackedMileageViewModel())
//    }
//}
