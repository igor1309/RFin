//
//  WeeklyMonthly.swift
//  Payroll
//
//  Created by Igor Malyarov on 03.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct WeeklyMonthly: View {
    var weeklyBrutto: Double
    var weeklyBruttoBrutto: Double
    var monthlyBrutto: Double
    var monthlyBruttoBrutto: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            BruttoBrutto(title: "Weekly",
                         brutto:        weeklyBrutto,
                         bruttoBrutto:  weeklyBruttoBrutto)
            
            BruttoBrutto(title: "Monthly",
                         brutto:        monthlyBrutto,
                         bruttoBrutto:  monthlyBruttoBrutto)
        }
    }
}

struct WeeklyMonthly_Previews: PreviewProvider {
    static var weeklyBrutto = 500.0
    static var previews: some View {
        NavigationView {
            WeeklyMonthly(weeklyBrutto:         weeklyBrutto,
                          weeklyBruttoBrutto:   weeklyBrutto * 1.25,
                          monthlyBrutto:        weeklyBrutto / 7 * 365,
                          monthlyBruttoBrutto:  weeklyBrutto / 7 * 365 * 1.25)
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
