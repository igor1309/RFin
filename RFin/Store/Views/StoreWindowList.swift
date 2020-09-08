//
//  StoreWindowList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct StoreWindowList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .samples
    
    private var storeWindows: [StoreWindow] { userData.restaurant.store.storeWindows }
    
    var body: some View {
        List {
            if userData.restaurant.store.isStoreEmpty {
                Group {
                    Text("about Store").foregroundColor(.systemTeal)
                    Text("Tapping \("StoreWindow")").foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            
            if !storeWindows.filter({ $0.isOn }).isEmpty {
                Section(
                    header: Text("On"),
                    footer: Text("Some comment.")
                ) {
                    ForEach(storeWindows.filter{ $0.isOn }, id: \.self) { storeWindow in
                        StoreWindowRow(storeWindow: storeWindow)
                    }
                }
            }
            
            if !storeWindows.filter({ !$0.isOn }).isEmpty {
                Section(
                    header: Text("Off"),
                    footer: Text("Some comment.")
                ) {
                    ForEach(storeWindows.filter{ !$0.isOn }, id: \.self) { storeWindow in
                        StoreWindowRow(storeWindow: storeWindow)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("StoreWindows")
        .navigationBarItems(
            leading: LeadingButton("Done") { presentation.wrappedValue.dismiss() },
            trailing: HStack {
                TrailingButtonSFSymbol("trash") { showAction = true }
                    .disabled(userData.restaurant.store.isStoreEmpty)
                TrailingButtonSFSymbol("waveform.path.badge.plus") { addRandom() }
                TrailingButtonSFSymbol("text.badge.plus") {
                    withAnimation {
                        modal = .samples
                        showModal = true }}})
        .actionSheet(isPresented: $showAction) {
            ActionSheet(title: Text("Delete all?".uppercased()),
                        message: Text("Are you 100% sure you want to delete all \("Connectins")?\nYou can't undo this action."),
                        buttons: [
                            .cancel(),
                            .destructive(Text("Yes, delete all")) {
                                deleteAll()
                            }])}
        .sheet(isPresented: $showModal) {
            if modal == .samples {
                StoreWindowSampleList()
                    .environmentObject(userData) }}
    }
    
    func addRandom() {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        withAnimation {
            userData.restaurant.store.addRandom()
        }
    }
    
    func deleteAll() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        withAnimation {
            userData.restaurant.store.reset()
        }
    }
}

struct StoreWindowList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StoreWindowList()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
