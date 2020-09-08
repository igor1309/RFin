//
//  QuickPLList.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct Pair: Hashable {
    var investment: Double
    var coverPriceVAT: Double
}



struct QuickPLList: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showModal = false
    @State private var modal: ModalType = .settings
    
    var isListEmpty: Bool { userData.quickie.quickPLs.isEmpty }
    
    var body: some View {
        NavigationView {
            List {
                if isListEmpty {
                    Group {
                        Text("about Quick P&L").foregroundColor(.systemTeal)
                        Text("Tapping \("Quick P&L")").foregroundColor(.secondary)
                    }
                    .font(.footnote)
                }
                
                ForEach(self.userData.quickie.pairs, id: \.self) { pair in
                    
                    Section(header: Text("Investment \(pair.investment.formattedGrouped) | Cover Price \(pair.coverPriceVAT.smartNotation)".uppercased())) {
                        
                        ForEach(self.userData.quickie.quickPLs
                            .filter { $0.investment == pair.investment
                                && $0.coverPriceVAT == pair.coverPriceVAT }, id: \.self) { quickPL in
                                    
                                    QuickPLRow(quickPL: quickPL)
                                        .environmentObject(self.settings)
                        }
                    }
                    
                }

                Section(footer: Text(isListEmpty ? "" : "ice").foregroundColor(.secondary)) { EmptyView() }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Quick P&Ls")
                
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("gear") {
                    self.modal = .settings
                    self.showModal = true
                },
                trailing: HStack {
                    TrailingButtonSFSymbol("waveform.path.badge.plus") {
                        self.addRandom()
                    }
                    TrailingButtonSFSymbol("text.badge.plus") {
                        withAnimation {
                            self.modal = .samples
                            self.showModal = true }}})
                
                .sheet(isPresented: $showModal) {
                    if self.modal == .samples {
                        QuickPLOptions()
                            .environmentObject(self.settings)
                            .environmentObject(self.userData)
                    }
                    
                    if self.modal == .settings {
                        QuickPLSettings()
                            .environmentObject(self.settings)
                            .environmentObject(self.userData)
                    }
            }
        }
    }
    
    func addRandom() {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        withAnimation {
            self.userData.quickie.addRandom()
        }
    }
}

struct QuickPLList_Previews: PreviewProvider {
    static var previews: some View {
        QuickPLList()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
