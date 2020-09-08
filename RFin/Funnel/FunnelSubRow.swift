//
//  FunnelSubRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelSubRow: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    var funnel: Funnel
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            ListRow2b(title: funnel.name,
                      subtitle: funnel.description,
                      extra: "\(currency.idd)\(funnel.budget.smartNotation) for \(funnel.traffic.smartNotation) views per \(funnel.period.id), \(funnel.conversion.formattedPercentageWithMax5Decimal)",
                detail: funnel.isRunning ? "\(funnel.guests.formattedGrouped) sales @ \(currency.idd)\(funnel.cps?.formattedGrouped ?? "n/a")" : "OFF",
                active: funnel.isRunning,
                full: true)
                .contentShape(Rectangle())
        }
    }
}

struct FunnelSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(sampleFunnels.indices) {
                FunnelSubRow(funnel: sampleFunnels[$0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
