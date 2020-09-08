//
//  SpreadsheetViewOriginal.swift
//  RFin
//
//  Created by Igor Malyarov on 15.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RowHeaderOriginal: View {
    var title: String
    var isHeaderFooter = false
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(isHeaderFooter ? .bold : .regular)
                .frame(width: 80, alignment: .leading)
            Divider()
        }
        .padding(.vertical, 4)
    }
}

struct RowItemOriginal: View {
    var title: String
    var isHeaderFooter = false
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(isHeaderFooter ? .bold : .regular)
                .frame(width: 90, alignment: .trailing)
            Divider()
        }
        .padding(.vertical, 4)
    }
}

struct SpreadsheetViewOriginal: View {
    @EnvironmentObject var userData: UserData
    
    var staff: Staff
    var payrollType: PayrollType
    
    var currencySymbol: String { userData.restaurant.currency.id }
    
    var leftsideHeaders: some View {
        
        VStack {
            RowHeaderOriginal(title: "p/d")
                .foregroundColor(.tertiary)
            
            ForEach(staff.products, id: \.self) { product in
                RowHeaderOriginal(title: product.id)
            }
            
            RowHeaderOriginal(title: "Total", isHeaderFooter: true)
        }
        .frame(width: 80)
    }
    
    func bodyStacks(division: Division?) -> some View {
        
        VStack {
            RowItemOriginal(title: division?.id ?? "Total", isHeaderFooter: true)
            
            ForEach(staff.products, id: \.self) { product in
                RowItemOriginal(title: self.formattedPayroll(product: product, division: division, type: self.payrollType))
            }
            
            RowItemOriginal(title: self.formattedPayroll(division: division, type: payrollType), isHeaderFooter: true)
        }
        .frame(width: 90)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                leftsideHeaders
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        ForEach([nil] + staff.divisions, id: \.self) { division in
                            
                            self.bodyStacks(division: division)
                        }
                    }
                }
                .foregroundColor(.secondary)
            }
            .font(.caption)
        }
        .padding(.horizontal)
    }
    
    
    func formattedPayroll(product: Product? = nil, division: Division? = nil, type: PayrollType) -> String {
        
        let payroll = staff.payroll(product: product, division: division, type: type)
        
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

struct SpreadsheetViewOriginal_Previews: PreviewProvider {
    static var previews: some View {
        SpreadsheetViewOriginal(staff: Staff(name: "Sample", positions: samplePositions), payrollType: .avgPayPerHourBruttoBrutto)
            .environmentObject(UserData())
        //            .environment(\.colorScheme, .dark)
    }
}
