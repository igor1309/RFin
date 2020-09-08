//
//  FunnelSampleRow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelSampleRow: View {
    var funnel: Funnel
    
    var body: some View {
        FunnelSubRow(funnel: funnel)
    }
}

struct FunnelSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                FunnelSampleRow(funnel: sampleFunnels[0])
                FunnelSampleRow(funnel: sampleFunnels[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
