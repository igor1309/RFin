//
//  StoreWindowSampleRow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct StoreWindowSampleRow: View {
    var storeWindow: StoreWindow
    
    var body: some View {
        StoreWindowSubRow(storeWindow: storeWindow)
    }
}

struct StoreWindowSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                StoreWindowSampleRow(storeWindow: sampleStoreWindows[0])
                StoreWindowSampleRow(storeWindow: sampleStoreWindows[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
