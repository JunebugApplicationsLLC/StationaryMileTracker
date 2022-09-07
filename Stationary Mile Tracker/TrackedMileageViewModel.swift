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
    
    func update(day: Day, for miles: Int) {
        milesTrackedForDay[day] = miles
    }
}
