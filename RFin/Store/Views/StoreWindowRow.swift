//
//  StoreWindowRow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct StoreWindowRow: View {
    @EnvironmentObject var userData: UserData
    var storeWindow: StoreWindow
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            StoreWindowSubRow(storeWindow: storeWindow)
                .onTapGesture {
                    self.modal = .detail
                    self.showModal = true }
                .contextMenu {
                    Button(action: {
                        self.toggleOn(self.storeWindow)
                    }) {
                        HStack {
                            Text("Turn \(storeWindow.isOn ? "Off" : "On")")
                            Image(systemName: storeWindow.isOn ? "xmark.circle" : "checkmark.circle")
                        }
                    }
                    Button(action: {
                        self.modal = .detail
                        self.showModal = true
                    }) {
                        HStack {
                            Text("Show/Edit \("StoreWindow")")
                            Image(systemName: "aspectratio")
                        }
                    }
                    Button(action: {
                        self.duplicate(self.storeWindow)
                    }) {
                        HStack {
                            Text("Duplicate \("StoreWindow")")
                            Image(systemName: "plus.square.on.square")
                        }
                    }
                    Button(action: {
                        self.showAlert = true
                    }) {
                        HStack {
                            Text("Delete \("StoreWindow")")
                            Image(systemName: "trash.circle")
                        }
                    }
                    .actionSheet(isPresented: $showAlert) {
                        ActionSheet(title: Text("Delete this \("StoreWindow?")".uppercased()),
                                    message: Text("You can't undo this action."),
                                    buttons: [
                                        .cancel(),
                                        .destructive(Text("Yes, delete it")) { self.delete() } ])}}
                
                .sheet(isPresented: $showModal) {
                    StoreWindowDetail(storeWindow: self.storeWindow, isNew: false)
                        .environmentObject(self.userData) }
        }
    }
    
    func toggleOn(_ storeWindow: StoreWindow) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        if userData.restaurant.store.toggleOn(storeWindow) {
            generator.impactOccurred()
        }
    }
    
    func duplicate(_ storeWindow: StoreWindow) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.store.duplicate(storeWindow)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.store.delete(storeWindow) {
                generator.impactOccurred()
            }
        }
    }
}

struct StoreWindowRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                StoreWindowRow(storeWindow: sampleStoreWindows[0])
                StoreWindowRow(storeWindow: sampleStoreWindows[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
