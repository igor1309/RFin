//
//  ShelfSampleRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ShelfSampleRow: View {
    @Binding var storeWindow: StoreWindow
    var shelf: Shelf

    var body: some View {
        ShelfSubRow(storeWindow: .constant(sampleStoreWindows[0]), shelf: shelf)
    }
}

struct ShelfSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ShelfSampleRow(storeWindow: .constant(sampleStoreWindows[0]),
                              shelf: sampleStoreWindows[0].shelfs[0])
                ShelfSampleRow(storeWindow: .constant(sampleStoreWindows[0]),
                              shelf: sampleStoreWindows[0].shelfs[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
