//
//  TrackedMilesChartView.swift
//  Stationary Mile Tracker
//
//  Created by Erica Stevens on 9/10/22.
//

import CalendarProgressTracker
import Charts
import SwiftUI

struct TrackedMilesChartView: View {
    @EnvironmentObject internal var trackedMileageViewModel: TrackedMileageViewModel
    @State var monthlyGoal = 500
    @State var dailyGoal = 15
    @State var selectedChartStyleTypeIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack( alignment: .center, spacing: 0) {
               dailyGoalButton
                Spacer()
                VStack(spacing: 2) {
                    Text("CHART TYPE")
                        .font(.caption)
                        .bold()
                    Picker("Chart Type", selection: $selectedChartStyleTypeIndex) {
                        ForEach(0..<ChartStyleType.allCases.count) { index in
                            Text(ChartStyleType.allCases[index].rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100)
                    .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                    .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                }
            }
            .padding([.leading, .trailing], 20)
            .opacity(trackedMileageViewModel.trackedDays.count < 2 ? 0 : 1)
            
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
                            .foregroundStyle(trackedMileageViewModel.milesTrackedForDay[day] ?? 0 > dailyGoal ? .cyan : .pink)
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
                                x: PlottableValue.value("Date", "\(Month.monthValue(for: day.monthName))/\(day.date)") ,
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
                        RuleMark(
                            y: .value("Average", trackedMileageViewModel.averageMilesPerDay)
                        )
                        .foregroundStyle(.green)
                        .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [3, 5]))
                        .annotation(position: .trailing) {
                            Text("avg")
                                .font(.caption2)
                                .bold()
                                .foregroundStyle(.green)
                        }
                    }
                }
                .padding()
            }
            HStack(alignment: .center, spacing: 0.0) {
                currentProgressLabel
                Text(" / ")
                    .font(.largeTitle)
                monthlyGoalButton
            }
        }
    }
    
    var currentProgressLabel: some View {
        Text("Total Miles: \(trackedMileageViewModel.totalMilesTracked)")
            .bold()
            .padding(8)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8.0)
    }
    
    var dailyGoalButton: some View {
        Text("Daily Goal: \(dailyGoal) miles")
            .bold()
            .padding(8)
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(8.0)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
    
    var monthlyGoalButton: some View {
        Text("Monthly Goal: \(monthlyGoal)")
            .bold()
            .padding(8)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8.0)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
    }
}

struct TrackedMilesChartView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedMilesChartView()
            .environmentObject(TrackedMileageViewModel(highlightedDateViewModel: HighlightedDateViewModel(Calendar(identifier: .gregorian), TimeZone(identifier: "EST")!)))
    }
}
