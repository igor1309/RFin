//
//  StoreWindowDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct StoreWindowDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var storeWindow: StoreWindow
    var isNew: Bool
    @State private var draft: StoreWindow
    @State private var isNameUsed = false
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .samples

    init(storeWindow: StoreWindow, isNew: Bool) {
        self.storeWindow = storeWindow
        self._draft = State(initialValue: storeWindow)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            StoreWindowEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(
                    leading: LeadingButton("Done") {
                        self.saveAndDismiss()
                    }
                    .disabled(draft.name.isEmpty),
                    trailing: HStack {
                        TrailingButtonSFSymbol("trash") {
                            self.showAction = true
                        }
                        .disabled(storeWindow.isStoreEmpty)
                        TrailingButtonSFSymbol("waveform.path.badge.plus") {
                            self.addRandom()
                        }
                        TrailingButtonSFSymbol("text.badge.plus") {
                            withAnimation {
                                self.modal = .samples
                                self.showModal = true }}})
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("Delete all?".uppercased()),
                                message: Text("Are you 100% sure you want to delete all \("Shelfs")?\nYou can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete all")) {
                                        self.deleteAll()
                                    }])}
                .sheet(isPresented: self.$showModal) {
                    if self.modal == .samples {
                        ShelfSampleList(storeWindow: self.$draft)
                            .environmentObject(self.userData) }}
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        if storeWindow == draft {
            presentation.wrappedValue.dismiss()
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if userData.restaurant.store.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.store.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.store.update(storeWindow, with: draft) {
            generator.notificationOccurred(.success)
            presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
    
    func addRandom() {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        withAnimation {
            draft.addRandom()
        }
    }
    
    func deleteAll() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        withAnimation {
            draft.reset()
        }
    }
}

struct StoreWindowDetail_Previews: PreviewProvider {
    static var previews: some View {
        StoreWindowDetail(storeWindow: sampleStoreWindows[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
