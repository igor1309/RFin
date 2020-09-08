//
//  LevelSubRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LevelSubRow: View {
    @Binding var funnel: Funnel
    var level: Level
    @State private var showModal = false
    
    var body: some View {
        ListRow2b(title: level.name,
                  subtitle: level.description,
                  detail: level.conversionRate.formattedPercentageWithDecimals,
                  full: true)
            .contentShape(Rectangle())
    }
}

struct LevelSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(sampleFunnels[0].levels.indices) {
                LevelSubRow(funnel: .constant(sampleFunnels[0]),
                            level: sampleFunnels[0].levels[$0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
