//
//  StoreWindowSampleList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct StoreWindowSampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("StoreWindow")")) {
                    Button("Add all Sample \("StoreWindows")") { self.showAction = true }
                }
                
                Section(header: Text("Sample StoreWindows".uppercased()),
                        footer: Text("Selected sample would be used to create a new entry to your StoreWindows.")) {
                            ForEach(sampleStoreWindows, id: \.self) { storeWindow in
                                StoreWindowSampleRow(storeWindow: storeWindow)
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.addSelected(storeWindow: storeWindow) }
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Sample")
                
            .navigationBarItems(leading: LeadingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
                
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("ADD ALL SAMPLES"),
                                message: Text("all samples confirmation"),
                                buttons: [
                                    .cancel(),
                                    .default(Text("Yes, add all samples")) {
                                        self.addAllSampleData() }])}
        }
    }
    
    func addAllSampleData() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        userData.restaurant.store.addAllSampleData()
        presentation.wrappedValue.dismiss()
    }
    
    func addSelected(storeWindow: StoreWindow) {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        withAnimation {
            userData.restaurant.store.add(storeWindow)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct StoreWindowSampleList_Previews: PreviewProvider {
    static var previews: some View {
        StoreWindowSampleList()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
