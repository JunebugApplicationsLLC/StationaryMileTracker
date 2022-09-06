//
//  ContentView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/6/22.
//

import CalendarProgressTracker
import SwiftUI

struct ContentView: View {
    @State var milesLogged = ""
    @FocusState var isFocused: Bool
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.timeZone) var timeZone: TimeZone
    @State var showingMileEntryPopover = false
    @State var selectedDate: Day?
    
    var body: some View {

        CalendarProgressTracker(calendar: calendar, timeZone: timeZone) { date in
            selectedDate = date
            showingMileEntryPopover.toggle()
        }
        .popover(isPresented: $showingMileEntryPopover) {
            VStack {
                Text("\($selectedDate.wrappedValue?.name ?? "Foo") \($selectedDate.wrappedValue?.date ?? 1)")
                TextField("Miles:", text: $milesLogged)
                    .focused($isFocused)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
