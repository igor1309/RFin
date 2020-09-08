//
//  StoreWindowSubRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct StoreWindowSubRow: View {
    @EnvironmentObject var userData: UserData
    var storeWindow: StoreWindow
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            ListRow2(title: storeWindow.name,
                     subtitle: storeWindow.description,
                     detail: storeWindow.isOn ? "ON" : "OFF",
                     active: storeWindow.isOn,
                     full: true)
                .contentShape(Rectangle())
        }
    }
}

struct StoreWindowSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                StoreWindowSubRow(storeWindow: sampleStoreWindows[0])
                StoreWindowSubRow(storeWindow: sampleStoreWindows[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
