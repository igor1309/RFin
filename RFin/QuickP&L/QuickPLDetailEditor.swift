//
//  QuickPLDetailEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct QuickPLDetailEditor: View {
    @EnvironmentObject var userData: UserData
    @Binding var draft: QuickPL
    
    @State private var showModal = false
    @State private var showActionSheet = false
    @State private var modal: ModalType = .investment
    
    var body: some View {
        Form {
            Section(header: Text("Investment"),
                    footer: Text("Ratio (percentage) is Investment to Revenue per year (\(draft.currency.idd)\(draft.revenuePerYear.threeSignificantDigits)). For model simplicity CAPEX is equal to Investment.")) {
                        RowWithAmountAndPercentage(title: "Investment", currency: draft.currency, amount: draft.capex, percentage: draft.capexPercentage)
                            .foregroundColor(.systemOrange)
                            .onTapGesture {
                                self.modal = .investment
                                self.showModal = true }
                        //                        Stepper("", value: $draft.investment, step: draft.currency == .rub ? 500_000 : 10_000)
                        //                            .font(.subheadline)
            }
            
            Section(header: Text("Revenue"),
                    footer: Text("Revenue ex VAT. Cover price \(draft.currency.idd)\(draft.coverPrice.threeSignificantDigits) (\(draft.currency.idd)\(draft.coverPriceVAT.threeSignificantDigits) with VAT). Tap 'Revenuer per month' to edit details.")) {
                        RowWithAmountAndPercentage(title: "Revenue per month", currency: draft.currency, amount: draft.revenuePerMonth, percentage: 0, noPercentage: true)
                            .foregroundColor(.systemOrange)
                            .onTapGesture {
                                self.modal = .revenue
                                self.showModal = true }
//                        RowWithStepperInt(title: "# of Covers per week", currency: .none, amount: $draft.noOfCoversPerWeek, step: 10)
                        Stepper(value: $draft.noOfCoversPerWeek, in: 50...3000, step: 10) {
                            Text(draft.currency.idd + draft.coverPrice.threeSignificantDigits)
                                + Text(" x ")
                                + Text(draft.noOfCoversPerWeek.formattedGrouped)
                                    .foregroundColor(.systemOrange)
                                + Text(" covers per week")
                        }
                        .font(.subheadline)
            }
            
            Section(header: Text("Expenses (per month)"),
                    footer: Text("Tap 'Expenses' to edit other Expenses.")) {
                        RowWithAmountAndPercentage(title: "Expenses", currency: draft.currency, amount: draft.costs, percentage: draft.costsPercentage)
                            .foregroundColor(.systemOrange)
                            .onTapGesture {
                                self.modal = .expenses
                                self.showModal = true }
                        //                .font(.subheadline)
                        RowWithAmountAndStepperPercentage4(
                            title: "Payroll",
                            currency: draft.currency,
                            amount: $draft.payrollRate,
                            percentage: draft.payrollPercentage,
                            step: draft.currency == .rub ? 50_000 : 1000)
            }
            
            Section(header: Text("Financial result (per month)"),
                    footer: Text("Percentage is ratio to Revenue. Data per month.")) {
                        Group {
                            RowWithAmountAndPercentage(title: "EBITDA", currency: draft.currency, amount: draft.ebitda, percentage: draft.ebitdaPercentage)
                                .foregroundColor(draft.ebitda > 0 ? .secondary : .systemRed)
                            RowWithAmountAndPercentage(title: "EBIT", currency: draft.currency, amount: draft.ebit, percentage: draft.ebitPercentage)
                                .foregroundColor(draft.ebit > 0 ? .secondary : .systemRed)
                            RowWithAmountAndPercentage(title: "Profit", currency: draft.currency, amount: draft.profit, percentage: draft.profitPercentage)
                                .foregroundColor(draft.profit > 0 ? .primary : .systemRed)
                        }
                        .font(.subheadline)
            }
            
            QuickPLDetailCFSection(draft: $draft)
        }
            
        .sheet(isPresented: $showModal) {
            if self.modal == .investment {
                InvestmentCapexModal(quickPL: self.$draft)
                    .environmentObject(self.userData)
            }
            
            if self.modal == .revenue {
                RevenueModal(quickPL: self.$draft)
                    .environmentObject(self.userData)
            }
            
            if self.modal == .expenses {
                ExpensesModal(quickPL: self.$draft)
                    .environmentObject(self.userData)
            }}
        
    }
}


struct QuickPLDetailEditor_Previews: PreviewProvider {
    static var previews: some View {
        QuickPLDetailEditor(draft: .constant(sampleQuickie.quickPLs[0]))
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
