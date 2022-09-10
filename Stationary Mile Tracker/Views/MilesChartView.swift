//
//  MilesChartView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/10/22.
//

import CalendarProgressTracker
import Charts
import SwiftUI

struct MilesChartView: View {
    @EnvironmentObject internal var trackedMileageViewModel: TrackedMileageViewModel
    @State var goal: Int = 500
    @State var selectedChartStyleTypeIndex = 0
    
    var body: some View {
        VStack {
            Picker("Chart Type", selection: $selectedChartStyleTypeIndex) {
                ForEach(0..<ChartStyleType.allCases.count) { index in
                    Text(ChartStyleType.allCases[index].rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 100)
            
            if trackedMileageViewModel.trackedDays.count < 2 {
                Spacer()
                Text("Log more miles to see trends over time")
                    .font(.caption).italic()
                Spacer()
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Miles Per Tracked Day")
                        .font(.subheadline)
                        .bold()
                    Chart(trackedMileageViewModel.trackedDays) { day in
                        if ChartStyleType.allCases[$selectedChartStyleTypeIndex.wrappedValue] == ChartStyleType.bar {
                            BarMark (
                                x: PlottableValue.value("Date", "\(day.name) \(day.date)") ,
                                y: PlottableValue.value("Miles", trackedMileageViewModel.milesTrackedForDay[day] ?? 0)
                            )
                            .foregroundStyle(.pink)
                            .annotation {
                                if let miles = trackedMileageViewModel.milesTrackedForDay[day] {
                                    Text(verbatim: "\(miles)")
                                        .font(.caption)
                                } else {
                                    EmptyView()
                                }
                            }
                        } else {
                            LineMark (
                                x: PlottableValue.value("Date", "\(day.name) \(day.date)") ,
                                y: PlottableValue.value("Miles", trackedMileageViewModel.milesTrackedForDay[day] ?? 0)
                            )
                            .foregroundStyle(.pink)
                            .symbol(Circle().strokeBorder(lineWidth: 2.0))
                            .annotation {
                                if let miles = trackedMileageViewModel.milesTrackedForDay[day] {
                                    
                                    Text(verbatim: "\(miles)")
                                        .font(.caption)
                                        .onAppear {
                                            print("\(miles)")
                                        }
                                } else {
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            HStack {
                Text("Total Miles: \(trackedMileageViewModel.totalMilesTracked) / ")
                goalButton
            }
        }
    }
    var goalButton: some View {
        Text("Goal: \(goal)")
            .bold()
            .padding(8)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8.0)
    }
}

struct MilesChartView_Previews: PreviewProvider {
    static var previews: some View {
        MilesChartView()
            .environmentObject(TrackedMileageViewModel(highlightedDateViewModel: HighlightedDateViewModel(Calendar(identifier: .gregorian), TimeZone(identifier: "EST")!)))
    }
}
