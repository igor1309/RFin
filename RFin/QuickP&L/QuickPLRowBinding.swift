//
//  QuickPLRowBinding.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct QuickPLRowBinding: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @Binding var draft: QuickPL
    
    @State private var showDetail = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        QuickPLSubRow(quickPL: draft)
            .onTapGesture {
                self.modal = .detail
                self.showDetail = true }
            
            .sheet(isPresented: $showDetail) {
                if self.modal == .detail {
                    
                    NavigationView {
                        QuickPLDetailEditor(draft: self.$draft)
                            
                            .navigationBarTitle("Quick P&L")
                    }
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
                    
                    
                }}
    }
}

struct QuickPLRowBinding_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                QuickPLRowBinding(draft: .constant(sampleQuickie.quickPLs[0]))
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
