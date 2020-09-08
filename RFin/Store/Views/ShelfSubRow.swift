//
//  ShelfSubRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ShelfSubRow: View {
    @Binding var storeWindow: StoreWindow
    var shelf: Shelf
    @State private var showModal = false
    
    var body: some View {
        ListRow2(title: shelf.name,
                 subtitle: shelf.description,
                 detail: shelf.number.formattedFlat,
                 active: shelf.isOn)
            .foregroundColor(shelf.isOn ? .primary : .secondary)
            .contentShape(Rectangle())
    }
}

struct ShelfSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ShelfSubRow(storeWindow: .constant(sampleStoreWindows[0]),
                shelf: sampleStoreWindows[0].shelfs[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
