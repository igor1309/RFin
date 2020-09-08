//
//  CostsSection.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CostsSection: View {
    @EnvironmentObject var userData: UserData
    @Binding var quickPL: QuickPL
    
    var body: some View {
        Section(header: Text("Costs, ex VAT"),
                footer: Text("All Expenses are entered 'netto' (without VAT). Percentage is given to Revenue ex VAT.")) {
            RowWithAmountAndStepperPercentage3(
                title: "Foodcost",
                currency: quickPL.currency,
                amount: quickPL.foodcost,
                percentage: $quickPL.foodcostPercentage,
                step: 0.01)
            
            RowWithAmountAndStepperPercentage4(
                title: "Payroll",
                currency: quickPL.currency,
                amount: $quickPL.payrollRate,
                percentage: quickPL.payrollPercentage,
                step: quickPL.currency == .rub ? 50_000 : 1000)

            RowWithAmountAndStepperPercentage4(
                title: "Rent",
                currency: quickPL.currency,
                amount: $quickPL.rentRate,
                percentage: quickPL.rentPercentage,
                step: quickPL.currency == .rub ? 50_000 : 100)

            RowWithAmountAndStepperPercentage3(
                title: "Utilities",
                currency: quickPL.currency,
                amount: quickPL.utilities,
                percentage: $quickPL.utilitiesPercentage)
            
            RowWithAmountAndStepperPercentage3(
                title: "Credit Cards Processing",
                currency: quickPL.currency,
                amount: quickPL.creditCardsProcessing,
                percentage: $quickPL.creditCardsProcessingPercentage)

            RowWithAmountAndStepperPercentage4(
                title: "Books",
                currency: quickPL.currency,
                amount: $quickPL.booksRate,
                percentage: quickPL.booksPercentage,
                step: quickPL.currency == .rub ? 10_000 : 100)
            
            RowWithAmountAndStepperPercentage3(
                title: "Marketing",
                currency: quickPL.currency,
                amount: quickPL.marketing,
                percentage: $quickPL.marketingPercentage)
            
            RowWithAmountAndStepperPercentage3(
                title: "All Other Expenses",
                currency: quickPL.currency,
                amount: quickPL.allOtherExpenses,
                percentage: $quickPL.allOtherExpensesPercentage)
        }
    }
}

struct CostsSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                CostsSection(quickPL: .constant(sampleQuickie.quickPLs[0]))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
