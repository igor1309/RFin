//
//  ExpensesModal.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ExpensesModal: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @Binding var quickPL: QuickPL
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total"),
                        footer: Text("Total monthly operational expenses.")) {
                            RowWithAmountAndPercentage(title: "Revenue ex VAT", currency: quickPL.currency, amount: quickPL.revenuePerMonth, percentage: 0, noPercentage: true)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            RowWithAmountAndPercentage(title: "Expenses per month", currency: quickPL.currency, amount: quickPL.costs, percentage: quickPL.costsPercentage)
                }
                CostsSection(quickPL: $quickPL)
            }
            .navigationBarTitle("Expenses")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct ExpensesModal_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesModal(quickPL: .constant(sampleQuickie.quickPLs[0]))
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
