//
//  ContentView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var trackedMileageViewModel: TrackedMileageViewModel
    
    var body: some View {
        NavigationView {
            CalendarTrackerView()
                .navigationTitle("Monthly Mile Tracker")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TrackedMileageViewModel(highlightedDateViewModel: HighlightedDateViewModel(Calendar(identifier: .gregorian), TimeZone(identifier: "EST")!)))
    }
}
