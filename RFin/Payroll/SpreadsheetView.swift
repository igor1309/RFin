//
//  SpreadsheetView.swift
//  RFin
//
//  Created by Igor Malyarov on 15.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RowHeaders: View {
    var showBrutto = false
    var body: some View {
        Group {
            RowHeader(title: "Qty")
            RowHeader(title: "Hours")
            if showBrutto { RowHeader(title: "€/h brutto") }
            RowHeader(title: "€/h br-brutto")
        }
        .foregroundColor(.secondary)
    }
}

struct RowHeader: View {
    var title: String
    var isHeaderFooter = false
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(isHeaderFooter ? .bold : .regular)
                .frame(width: 98, alignment: .leading)
        }
        .padding(.vertical, 4)
    }
}

struct RowItem: View {
    var title: String
    var isHeaderFooter = false
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(isHeaderFooter ? .bold : .regular)
                .frame(width: 96, alignment: .trailing)
        }
        .padding(.vertical, 4)
    }
}

struct SpreadsheetView: View {
    
    @EnvironmentObject var userData: UserData
    
    var staff: Staff
    
    @State private var showIndex = false
    @State private var showBrutto = false
    
    var currencySymbol: String { userData.restaurant.currency.id }
    
    var leftsideHeaders: some View {
        VStack {
            RowHeader(title: "p/d")
                .foregroundColor(.tertiary)
            
            ForEach(staff.products, id: \.self) { product in
                VStack(alignment: .leading, spacing: 0) {
                    RowHeaders()
                    
                    RowHeader(title: product.id.uppercased())
                        .background(Color.secondarySystemBackground)
                }
            }
            
            RowHeaders()
            
            RowHeader(title: "Total".uppercased(), isHeaderFooter: true)
                .foregroundColor(.primary)
                .background(Color.secondarySystemBackground)
        }
        .frame(width: 98)
    }
    
    func bodyStacks(division: Division?) -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
            RowItem(title: division?.id ?? "Total", isHeaderFooter: true)
                .foregroundColor(.primary)
            
            ForEach(staff.products, id: \.self) { product in
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        RowItem(title: self.formattedPayroll(product: product, division: division, type: .headcount))
                        RowItem(title: self.formattedPayroll(product: product, division: division, type: .hoursPerWeek))
                        if self.showBrutto { RowItem(title: self.formattedPayroll(product: product, division: division, type: .avgPayPerHourBrutto)) }
                        RowItem(title: self.formattedPayroll(product: product, division: division, type: .avgPayPerHourBruttoBrutto))
                    }
                    .foregroundColor(division == nil ? .primary : .secondary)
                    
                    RowItem(title: self.formattedPayroll(product: product, division: division, type: .monthlyBruttoBrutto))
                        .foregroundColor(.primary)
                        .background(Color.secondarySystemBackground)
                }
            }
            
            Group {
                RowItem(title: self.formattedPayroll(division: division, type: .headcount))
                RowItem(title: self.formattedPayroll(division: division, type: .hoursPerWeek))
                if showBrutto { RowItem(title: self.formattedPayroll(division: division, type: .avgPayPerHourBrutto)) }
                RowItem(title: self.formattedPayroll(division: division, type: .avgPayPerHourBruttoBrutto))
            }
            .foregroundColor(division == nil ? .primary : .secondary)
            
            RowItem(title: self.formattedPayroll(division: division, type: .monthlyBruttoBrutto), isHeaderFooter: true)
                .foregroundColor(.primary)
                .background(Color.secondarySystemBackground)
        }
        .frame(width: 96)
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
            
            Text("Totals = Payroll Monthly Brutto Brutto")
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Toggle("Show Index & Share", isOn: $showIndex)
                .padding(.top)
        }
        .padding(.horizontal)
    }
    
    func formattedPayroll(product: Product? = nil, division: Division? = nil, type: PayrollType) -> String {
        
        let payroll = staff.payroll(product: product, division: division, type: type)
        let totalPayroll = staff.payroll(type: type)
        
        if payroll == 0 { return "-" }
        
        if showIndex {
            return (payroll/totalPayroll).formattedPercentageWith1Decimal
        } else {
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
}

struct SpreadsheetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpreadsheetView(staff: Staff(name: "Sample", positions: samplePositions))
        }
        .environmentObject(UserData())
        //        .environment(\.colorScheme, .dark)
    }
}
