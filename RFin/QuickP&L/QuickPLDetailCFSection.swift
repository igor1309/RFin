//
//  QuickPLDetailCFSection.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct QuickPLDetailCFSection: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @Binding var draft: QuickPL
    
    var body: some View {
        Group {
            Section(header: Text("Cash Flow Earnings (per month)"),
                    footer: Text("Cash Earnings (or Cash Flow Earnings, or Net Cash Flow, or Net Income Plus Depreciation (NIPD)) is Profit + Depreciation (non-cash expenses in general).\n\n'Investment to Cash Earnings' is a number of months to recover Investment using 100% of Cash Earnings.\n\n* NOTE: There are no estimates of the project's ramp up period. Add 3-6 (6-12) months to have a good enough approximation.")) {
                        Group {
                            RowWithAmountAndPercentage(title: "Cash Earnings", currency: draft.currency, amount: draft.cashEarnings, percentage: draft.cashEarningsPercentage)
                            HStack(alignment: .firstTextBaseline) {
                                Text("Investment to Cash Earnings")
                                Spacer()
                                if draft.investmentToNetCashFlow > 0 && draft.investmentToNetCashFlow <= Double(settings.investmentReturnPeriodThreshhold) {
                                    Image(systemName: "star.circle")
                                }
                                Text(draft.investmentToNetCashFlow.formattedGrouped + "*")
                            }
                        }
                        .foregroundColor(.systemYellow)
            }
            
            Section(header: Text("Warren Buffett (per month)").padding(.top),
                    footer: Text("Maintenance Capital Expenditures is monthly average of Average Annual Maintenance Capital Expenditures.\n\nWarren Buffett has promoted the concept of “Owner Earnings”. Owner Earnings takes it one step beyond Cash Earnings by subtracting the approximate amount of capital expenditures it  takes to keep the company a going concern.\nOptions would include reinvesting for growth, debt reduction, dividends, and stock buybacks.")) {
                        Group {
                            RowWithAmountAndStepperPercentage3(
                                title: "Maintenance CAPEX",
                                currency: draft.currency,
                                amount: draft.mce,
                                percentage: $draft.mcePercentage,
                                step: 0.01)
                            RowWithAmountAndPercentage(title: "Owner Earnings", currency: draft.currency, amount: draft.ownerEarnings, percentage: draft.ownerEarningsPercentage)
                                .foregroundColor(.systemTeal)
                        }
            }
        }
    }
}

struct QuickPLDetailCFSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                QuickPLDetailCFSection(draft: .constant(sampleQuickie.quickPLs[0]))
            }
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
