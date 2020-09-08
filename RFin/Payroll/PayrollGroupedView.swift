//
//  PayrollGroupedView.swift
//  RFin
//
//  Created by Igor Malyarov on 12.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayrollGroupedView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var staff: Staff
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        NavigationView {
            Form {
                //                StaffSummary(staff: staff)
                
                Section(
                    header: HStack(alignment: .firstTextBaseline) {
                        Text("TOTAL: \(staff.headcount.formattedGrouped) \(staff.headcount == 1 ? "person" : "people")")
                            .foregroundColor(.primary)
                        Spacer()
                        Group {
                            Text("brutto")
                                .frame(minWidth: 65, alignment: .trailing)
                            Text("brto-brutto")
                                .frame(minWidth: 70, alignment: .trailing)
                        }
                        .foregroundColor(.secondary)
                }) {
                    VStack(alignment: .leading, spacing: 4) {
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
                
                PayrollGroupingPicker()
                
                
                if settings.selectedPayrollGrouping == .byProduct {
                    ForEach(self.staff.products, id: \.self) { product in
                        Section(
                            header: Text("\(product.id): \(self.staff.payroll(product: product, type: .headcount).formattedGrouped) \(self.staff.payroll(product: product, type: .headcount) == 1 ? "person" : "people")")
                                .foregroundColor(.primary)) {
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        BruttoBrutto(title: "\(self.staff.payroll(product: product, type: .hoursPerWeek).formattedGroupedWith1Decimal) h/week. Avg \(self.currency.idd)/h",
                                            brutto:       self.staff.payroll(product: product, type: .avgPayPerHourBrutto),
                                            bruttoBrutto: self.staff.payroll(product: product, type: .avgPayPerHourBruttoBrutto),
                                            hasDecimals: true)
                                        
                                        WeeklyMonthlyDpt(staff: self.staff, product: product)
                                    }
                        }
                    }
                }
                
                if settings.selectedPayrollGrouping == .byDivision {
                    ForEach(self.staff.divisions, id: \.self) { division in
                        Section(
                            header: Text("\(division.id): \(self.staff.payroll(division: division, type: .headcount).formattedGrouped) \(self.staff.payroll(division: division, type: .headcount) == 1 ? "person" : "people")")
                                .foregroundColor(.primary)) {
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        BruttoBrutto(title: "\(self.staff.payroll(division: division, type: .hoursPerWeek).formattedGroupedWith1Decimal) h/week. Avg \(self.currency.idd)/h",
                                            brutto:       self.staff.payroll(division: division, type: .avgPayPerHourBrutto),
                                            bruttoBrutto: self.staff.payroll(division: division, type: .avgPayPerHourBruttoBrutto),
                                            hasDecimals: true)
                                        
                                        WeeklyMonthlyDpt(staff: self.staff, division: division)
                                    }
                        }
                    }
                }
                
                if settings.selectedPayrollGrouping == .detailed {
                    ForEach(self.staff.products, id: \.self) { product in
                        ForEach(self.staff.divisions, id: \.self) { division in
                            Section(
                                header: Text("\(product.id)/\(division.id): \(self.staff.payroll(product: product, division: division, type: .headcount).formattedGrouped) \(self.staff.payroll(product: product, division: division, type: .headcount) == 1 ? "person" : "people")")
                                    .foregroundColor(.primary)) {
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            
                                            BruttoBrutto(title: "\(self.staff.payroll(product: product, division: division, type: .hoursPerWeek).formattedGroupedWith1Decimal) h/week. Avg \(self.currency.idd)/h",
                                                brutto:       self.staff.payroll(product: product, division: division, type: .avgPayPerHourBrutto),
                                                bruttoBrutto: self.staff.payroll(product: product, division: division, type: .avgPayPerHourBruttoBrutto),
                                                hasDecimals: true)
                                            
                                            WeeklyMonthlyDpt(staff: self.staff, product: product, division: division)
                                        }
                            }
                        }
                    }
                }
            }
                // .navigationBarTitle(Text("Payroll by Division"))
                .navigationBarTitle(Text(staff.name + ": " + settings.selectedPayrollGrouping.id), displayMode: .inline)
        }
    }
}

struct PayrollGroupediews: PreviewProvider {
    static var previews: some View {
        PayrollGroupedView(staff: sampleStaff)
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
    }
}
