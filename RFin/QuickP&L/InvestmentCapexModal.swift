//
//  InvestmentCapexModal.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct InvestmentCapexModal: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @Binding var quickPL: QuickPL
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Investment (Capex)".uppercased()),
                        footer: Text("CAPEX is equal to Investment and used to calculate average linear depreciation of assets.")) {
                            RowWithStepperDouble(title: "Investment", currency: quickPL.currency, amount: $quickPL.investment, step: quickPL.currency == .rub ? 500_000 : 10_000)
                            HStack {
                                Text("Currency")
                                Spacer()
                                    .frame(minWidth: 10)
                                CurrencySegmentedControl(selection: $quickPL.currency)
                            }
                }
                
                Section(header: Text("Depreciation".uppercased()),
                        footer: Text("Use accounting rules to set Depreciation Period. Tax authorities don't like aggressive depreciation. Using too short periods will result in unreasonably low tax calculations.")) {
                            RowWithAmountAndPercentage(title: "Depreciation per month", currency: quickPL.currency, amount: quickPL.depreciation, percentage: quickPL.depreciationPercentage)
                            RowWithStepperInt(title: "Depreciation Period", currency: .none, amount: $quickPL.depreciationPeriodForTaxation)
                }
                
                Section(header: Text("Corporate Income Tax".uppercased())) {
                    RowWithAmountAndPercentage(title: "Tax", currency: quickPL.currency, amount: quickPL.tax, percentage: quickPL.taxPercentage)
                    RowWithStepperPercentage(title: "Tax Rate", amount: $quickPL.taxRate)
                }
            }
            .navigationBarTitle("Investment, etc")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct InvestmentCapexModal_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentCapexModal(quickPL: .constant(sampleQuickie.quickPLs[0]))
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
