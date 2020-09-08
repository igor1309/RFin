//
//  FunnelBottomSection.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelBottomSection: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    @Binding var draft: Funnel
    
    var body: some View {
        Section(header: Text("Bottom (per \(draft.period.id))".uppercased()),
                footer: Text("Cost Per Guest is Cost Per Sale (CPS).")) {
                    
                    ImageRow(image: "briefcase",
                             title: "Budget",
                             detail: currency.idd + draft.budget.formattedGrouped)
                        .foregroundColor(.systemYellow)
                    
                    ImageRow(image: "tornado",
                             title: "Conversion " + draft.conversion.formattedPercentageWithMax5Decimal,
                             detail: "1 / \((1 / draft.conversion).formattedGrouped)")
                        .foregroundColor(.systemPurple)
                    
                    ImageRow(image: "person.2",
                             title: "Guests (sales)",
                             detail: draft.guests.formattedGrouped)
                    
                    ImageRow(image: "dollarsign.circle",
                             title: "Cost Per Sale",
                             detail: (draft.cps == nil ? "" : currency.idd) + (draft.cps?.formattedGrouped ?? "n/a"))
                        .foregroundColor(.systemTeal)
        }
    }
}

struct FunnelBottomSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                FunnelBottomSection(draft: .constant(sampleFunnels[0]))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
