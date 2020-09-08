//
//  BruttoBrutto.swift
//  Payroll
//
//  Created by Igor Malyarov on 03.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct BruttoBrutto: View {
    @EnvironmentObject var userData: UserData
    var title: String
    var brutto: Double
    var bruttoBrutto: Double
    var hasDecimals = false
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if hasDecimals {
                Text(currency.idd + brutto.formattedGroupedWithDecimals)
                Text(currency.idd + bruttoBrutto.formattedGroupedWithDecimals)
                    .frame(minWidth: 70, alignment: .trailing)
            } else {
                Text(currency.idd + brutto.formattedGrouped)
                Text(currency.idd + bruttoBrutto.formattedGrouped)
                    .frame(minWidth: 70, alignment: .trailing)
            }
        }
        .font(.footnote)
        .foregroundColor(.secondary)
    }
}


struct BruttoBrutto_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                BruttoBrutto(title: "per Hour", brutto: 13.0, bruttoBrutto: 13.3, hasDecimals: true)
                BruttoBrutto(title: "per Month", brutto: 2_134, bruttoBrutto: 3_432)
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
