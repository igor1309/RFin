//
//  RevenueEstimateView.swift
//  Investment Evaluation
//
//  Created by Igor Malyarov on 20.07.2020.
//

import SwiftUI
import SwiftPI

struct RevenueEstimateView: View {
    private let capacities: [Int] = [80, 100, 120, 150, 160, 200]
    private let turnovers: [Double] = [1/3, 1/2, 1, 1.5, 2, 2.5, 3]
    private let workingDays: [Int] = [20, 25, 30]
    private let averageChecks: [Int] = [1000, 1500, 2000, 2500, 2800, 3000]
    
    @State private var seatingCapacity: Int = 160
    @State private var dailyTurnover: Double = 1/2
    @State private var workingDaysPerMonth: Int = 30
    @State private var averageCover: Int = 2800
    
    private var revenue: Double {
        Double(seatingCapacity) * dailyTurnover * Double(workingDaysPerMonth) * Double(averageCover)
    }
    
    var body: some View {
        Group {
            TitleView("Revenue \(revenue.formattedGrouped)")
            
            Section(
                header: Text("Capacity, seats")
            ) {
                Picker("Capacity", selection: $seatingCapacity) {
                    ForEach(capacities, id: \.self) { capacity in
                        Text("\(capacity)").tag(capacity)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(
                header: Text("Turnover per Day")
            ) {
                Picker("Turnover", selection: $dailyTurnover) {
                    ForEach(turnovers, id: \.self) { turnover in
                        Text("\(turnover, specifier: "%.1f")").tag(turnover)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(
                header: Text("Working Days per Month")
            ) {
                Picker("Working Days per Month", selection: $workingDaysPerMonth) {
                    ForEach(workingDays, id: \.self) { days in
                        Text("\(days)").tag(days)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(
                header: Text("Average Cover")
            ) {
                Picker("Average Check", selection: $averageCover) {
                    ForEach(averageChecks, id: \.self) { check in
                        Text("\(check)").tag(check)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct PageThree_Previews: PreviewProvider {
    static var previews: some View {
        RevenueEstimateView()
            .preferredColorScheme(.dark)
    }
}
