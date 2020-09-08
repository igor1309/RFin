//
//  PayrollMatrix.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayrollMatrix: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var staff: Staff
    
    var currencySymbol: String { userData.restaurant.currency.id }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                SpreadsheetView(staff: staff)
                
                // SpreadsheetViewOriginal(staff: staff, payrollType: settings.selectedPayrollType)
                
//                Divider().padding()
                
//                VStack(alignment: .leading, spacing: 8) {
//
//                    HStack(alignment: .top, spacing: 8) {
//                        Text(" ")
//                            .frame(width: 100, alignment: .leading)
//                            .foregroundColor(.systemIndigo)
//                        ForEach(self.staff.divisions, id: \.self) { division in
//                            Text(division.id)
//                                .frame(width: 70, alignment: .trailing)
//                        }
//                        Text("Total")
//                            .frame(width: 70, alignment: .trailing)
//                            .foregroundColor(.primary)
//
//                    }
//
//                    ForEach(staff.products, id: \.self) { product in
//                        HStack {
//                            Text(product.id)
//                                .frame(width: 100, alignment: .leading)
//                            ForEach(self.staff.divisions, id: \.self) { division in
//                                Text(self.formattedPayroll(product: product, division: division, type: self.settings.selectedPayrollType))
//                                    .frame(width: 70, alignment: .trailing)
//                            }
//                            Text(self.formattedPayroll(product: product, type: self.settings.selectedPayrollType))
//                                .frame(width: 70, alignment: .trailing)
//                                .foregroundColor(.primary)
//                        }
//                    }
//
//                    HStack(alignment: .top, spacing: 8) {
//                        Text("Total")
//                            .frame(width: 100, alignment: .leading)
//                        ForEach(self.staff.divisions, id: \.self) { division in
//                            Text(self.formattedPayroll(division:  division, type: self.settings.selectedPayrollType))
//                                .frame(width: 70, alignment: .trailing)
//                        }
//                        Text(self.formattedPayroll(type: settings.selectedPayrollType))
//                            .frame(width: 70, alignment: .trailing)
//                    }
//                    .foregroundColor(.primary)
//                }
//                .font(.footnote)
//                .foregroundColor(.secondary)
                
//                Picker("Select PayrollType", selection: $settings.selectedPayrollType) {
//                    ForEach(PayrollType.allCases, id: \.self) { type in
//                        Text(type.id).tag(type)
//                    }
//                }
//                .labelsHidden()
                
                Spacer()
            }
            .padding(.top)
            .navigationBarTitle(Text("Product Division Matrix"), displayMode: .inline)
        }
    }
    
    func formattedPayroll(product: Product? = nil, division: Division? = nil, type: PayrollType) -> String {
        
        let payroll = staff.payroll(product: product, division: division, type: self.settings.selectedPayrollType)
        
        switch type {
        case .headcount:
            return payroll.formattedGrouped
        case .weeklyBrutto, .weeklyBruttoBrutto, .monthlyBrutto, .monthlyBruttoBrutto:
            return currencySymbol + payroll.formattedGrouped
        case .hoursPerWeek:
            return payroll.formattedGroupedWith1Decimal
        case .avgPayPerHourBrutto, .avgPayPerHourBruttoBrutto:
            return currencySymbol + payroll.formattedGroupedWithDecimals
        }
    }
}

struct PayrollMatrix_Previews: PreviewProvider {
    static var previews: some View {
        PayrollMatrix(staff: Staff(name: "Sample", positions: samplePositions))
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
