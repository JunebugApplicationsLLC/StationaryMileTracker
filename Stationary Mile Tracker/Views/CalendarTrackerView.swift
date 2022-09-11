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
            VStack(spacing: 8) {
                calendarView
                TrackedMilesChartView()
                    .frame(height: proxy.size.height * 0.4)
            }
        }
    }
    
    var calendarView: some View {
        CalendarProgressTracker(trackedMileageViewModel.highlightedDateViewModel) { date in
            selectedDay = date
        }
        .sheet(item: $selectedDay) { selectedDay in
            VStack(alignment: .center) {
                Text("\(selectedDay.name) \(selectedDay.date)")
                TextField(value: milesForDay, format: .number) {
                    Text("Miles")
                }
                .focused($isFocused)
                .keyboardType(.decimalPad)
                .foregroundColor(.neumorphictextColor)
                .background(Color.background)
                .padding()
                .cornerRadius(6)
                .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                .frame(alignment: .center)
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

extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}
