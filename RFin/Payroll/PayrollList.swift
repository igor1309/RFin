//
//  PayrollList.swift
//  Payroll
//
//  Created by Igor Malyarov on 02.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayrollList: View {
    @EnvironmentObject var userData: UserData

    @Binding var staff: Staff
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        List {
            ForEach(staff.divisions, id: \.self) { division in
                
                Section(
                    header: Text("\(division.id.uppercased()): \(self.staff.payroll(division: division, type: .headcount).formattedGrouped) \(self.staff.payroll(division: division, type: .headcount) == 1 ? "person" : "people")")
                        .foregroundColor(.primary),
                    footer: VStack(alignment: .leading, spacing: 3) {
                        
                        BruttoBrutto(title: "\(self.staff.payroll(division: division, type: .hoursPerWeek).formattedGroupedWith1Decimal) h/week. Avg \(self.currency.idd)/h",
                            brutto:       self.staff.payroll(division: division, type: .avgPayPerHourBrutto),
                            bruttoBrutto: self.staff.payroll(division: division, type: .avgPayPerHourBruttoBrutto),
                            hasDecimals: true)
                        
                        WeeklyMonthlyDpt(staff: self.staff, division: division).padding(.bottom)
                }) {
                    ForEach(self.staff.positions
                        .filter({ $0.division == division })
                        //                        .sorted(by: { $0.payPerWeekBrutto > $1.payPerWeekBrutto })
                    , id: \.self) { position in
                        
                        PayrollRow(staff: self.$staff, position: position)
                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

struct PayrollList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PayrollList(staff: .constant(UserData().restaurant.staffVersions.versions[0]))
                
                .navigationBarTitle("Payroll")
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
