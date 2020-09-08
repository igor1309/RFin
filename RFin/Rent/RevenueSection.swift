//
//  Revenue.swift
//  Rent
//
//  Created by Igor Malyarov on 27.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RevenueSection: View {
    @EnvironmentObject var userData: UserData
    @Binding var space: Space
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Section(
            header: Text("Expected monthly Revenue")
        ) {
            HStack {
                Stepper(
                    value: $space.expectedRevenue,
                    in: currency == .rub ? 3_000_000...30_000_000 : 10_000...250_000,
                    step: currency == .rub ? 500_000 : 5_000
                ) {
                    Row(title: "Revenue", detail: currency.idd + space.expectedRevenue.formattedGrouped)
                }
            }
        }
    }
}

struct Revenue_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            RevenueSection(space: .constant(Space(sample: true)))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
