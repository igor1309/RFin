//
//  QuickPLOptions.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct QuickPLOptions: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    //    @EnvironmentObject var settings: SettingsStore
    
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    footer: Text("add all samples or select \("Quick P&L")")
                ) {
                    Button("Add all Samples \("Quick P&L")") { self.showAction = true }
                }
                
                ForEach(sampleQuickie.quickPLs.map { $0.currency }.removingDuplicates(), id: \.self) { currency in
                    
                    Section(
                        header: Text(currency.idd)
                    ) {
                        ForEach(sampleQuickie.quickPLs
                                    .filter { $0.currency == currency }, id: \.self) { quickPL in
                            
                            QuickPLSubRow(quickPL: quickPL)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.addSelected(quickPL: quickPL)
                                    
                                }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Add Sample")
            .navigationBarItems(
                trailing: TrailingButton("Done") {
                    presentation.wrappedValue.dismiss()
                }
            )
            .actionSheet(isPresented: $showAction) {
                ActionSheet(title: Text("ADD ALL SAMPLES"), message: Text("all samples confirmation"), buttons: [
                                .cancel(),
                                .default(Text("Yes, add all samples")) {
                                    self.addAllSampleData() }])}
        }
    }
    
    func addAllSampleData() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        userData.quickie.addAllSampleData()
        self.presentation.wrappedValue.dismiss()
    }
    
    func addSelected(quickPL: QuickPL) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        withAnimation {
            userData.quickie.add(quickPL)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct QuickPLOptions_Previews: PreviewProvider {
    static var previews: some View {
        QuickPLOptions()
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
