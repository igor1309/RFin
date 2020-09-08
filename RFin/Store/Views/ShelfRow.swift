//
//  ShelfRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ShelfRow: View {
    @Binding var storeWindow: StoreWindow
    var shelf: Shelf
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        ShelfSubRow(storeWindow: $storeWindow, shelf: shelf)
            .onTapGesture {
                self.modal = .detail
                self.showModal = true }
            .contextMenu {
                Button(action: {
                    self.toggleOn(self.shelf)
                }) {
                    HStack {
                        Text("Turn \(shelf.isOn ? "Off" : "On")")
                        Image(systemName: shelf.isOn ? "xmark.circle" : "checkmark.circle")
                    }
                }
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Show/Edit \("Shelf")")
                        Image(systemName: "aspectratio")
                    }
                }
                Button(action: {
                    self.duplicate(self.shelf)
                }) {
                    HStack {
                        Text("Duplicate \("Shelf")")
                        Image(systemName: "plus.square.on.square")
                    }
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("Shelf")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("Shelf?")".uppercased()),
                                message: Text("You can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
            
            .sheet(isPresented: $showModal) {
                ShelfDetail(storeWindow: self.$storeWindow, shelf: self.shelf, isNew: false) }
    }
    
    func toggleOn(_ shelf: Shelf) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        if storeWindow.toggleOn(shelf) {
            generator.impactOccurred()
        }
    }
    
    func duplicate(_ shelf: Shelf) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            storeWindow.duplicate(shelf)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if storeWindow.delete(shelf) {
                generator.impactOccurred()
            }
        }
    }
}

struct ShelfRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ShelfRow(storeWindow: .constant(sampleStoreWindows[0]),
                        shelf: sampleStoreWindows[0].shelfs[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
