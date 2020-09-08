//
//  LevelSampleRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LevelSampleRow: View {
    @Binding var funnel: Funnel
    var level: Level

    var body: some View {
        LevelSubRow(funnel: .constant(sampleFunnels[0]), level: level)
    }
}

struct LevelSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                LevelSampleRow(funnel: .constant(sampleFunnels[0]),
                              level: sampleFunnels[0].levels[0])
                LevelSampleRow(funnel: .constant(sampleFunnels[0]),
                              level: sampleFunnels[0].levels[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
