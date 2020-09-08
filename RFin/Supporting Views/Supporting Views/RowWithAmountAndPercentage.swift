//
//  RowWithAmountAndPercentage.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RowWithAmountAndPercentage: View {
    var title: String
    var currency: Currency
    var amount: Double
    var percentage: Double
    var noPercentage = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
            Spacer()
            Group {
                Text(currency.idd + amount.threeSignificantDigits)
                Text(noPercentage ? "" : percentage.formattedPercentageWithDecimals)
                    .foregroundColor(.systemTeal)
                    .frame(minWidth: 70, alignment: .trailing)
            }
            .font(.subheadline)
        }
    }
}

struct RowWithAmountAndPercentage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                RowWithAmountAndPercentage(title: "Some param", currency: .euro, amount: 123_456, percentage: 0.789)
                RowWithAmountAndPercentage(title: "Some param", currency: .euro, amount: 123_456, percentage: 0.789, noPercentage: true)
            }
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
