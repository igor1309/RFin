//
//  QuickPLRow.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct QuickPLRow: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var quickPL: QuickPL    
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .settings
    
    var body: some View {
        QuickPLSubRow(quickPL: quickPL)
            .contentShape(Rectangle())
            .onTapGesture {
                self.modal = .detail
                self.showModal = true }
            .contextMenu {
                Button(action: {
                    self.userData.scenario.update(with: self.quickPL)
                    self.modal = .scenario
                    self.showModal = true
                }) {
                    Image(systemName: "rectangle.3.offgrid")
                    Text("Compare Scenarios")
                }
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    Image(systemName: "aspectratio")
                    Text("Show/Edit \("Quick P&L")")
                }
                Button(action: {
                    self.duplicate(self.quickPL)
                }) {
                    Image(systemName: "plus.square.on.square")
                    Text("Duplicate \("Quick P&L")")
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    Image(systemName: "trash.circle")
                    Text("Delete \("Quick P&L")")
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("Quick P&L?")".uppercased()),
                                message: Text("can't delete"),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
            
            .sheet(isPresented: $showModal) {
                if self.modal == .detail {
                    QuickPLDetail(quickPL: self.quickPL, isNew: false)
                        .environmentObject(self.userData)
                        .environmentObject(self.settings) }
                
                if self.modal == .scenario {
                    ScenarioList()
                        .environmentObject(self.userData)
                        .environmentObject(self.settings) }}
    }
    
    func duplicate(_ quickPL: QuickPL) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            self.userData.quickie.add(self.quickPL)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.quickie.delete(quickPL) {
                generator.impactOccurred()
            }
        }
    }
}

struct QuickPLRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                QuickPLRow(quickPL: sampleQuickie.quickPLs[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
