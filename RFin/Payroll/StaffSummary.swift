//
//  StaffSummary.swift
//  RFin
//
//  Created by Igor Malyarov on 11.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct StaffSummary: View {
    @EnvironmentObject var userData: UserData

    var staff: Staff
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text("TOTAL: \(staff.headcount.formattedGrouped) \(staff.headcount == 1 ? "person" : "people")")
                    .font(.footnote)
                Spacer()
                if #available(iOS 14.0, *) {
                    Group {
                        Text("brutto")
                            .frame(minWidth: 65, alignment: .trailing)
                        Text("brto-brutto")
                            .frame(minWidth: 70, alignment: .trailing)
                    }
                    .foregroundColor(.secondary)
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            BruttoBrutto(title: "\(staff.hoursPerWeek.formattedGroupedWith1Decimal) h/week. Avg \(currency.idd)/h",
                brutto:       staff.avgPayPerHourBrutto,
                bruttoBrutto: staff.avgPayPerHourBruttoBrutto,
                hasDecimals: true)
            
            WeeklyMonthly(weeklyBrutto: staff.payPerWeekBrutto,
                          weeklyBruttoBrutto: staff.payPerWeekBruttoBrutto,
                          monthlyBrutto: staff.payPerMonthBrutto,
                          monthlyBruttoBrutto: staff.payPerMonthBruttoBrutto)
        }
    }
}

struct StaffSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                StaffSummary(staff: sampleStaff)
                
                Spacer()
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
