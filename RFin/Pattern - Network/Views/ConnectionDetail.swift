//
//  ConnectionDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ConnectionDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var connection: Connection
    var isNew: Bool
    @State private var draft: Connection
    @State private var isNameUsed = false
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .samples

    init(connection: Connection, isNew: Bool) {
        self.connection = connection
        self._draft = State(initialValue: connection)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            ConnectionEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(
                    leading: LeadingButton("Done") { self.saveAndDismiss() }
                        .disabled(draft.name.isEmpty),
                    trailing: HStack {
                        TrailingButtonSFSymbol("trash") { self.showAction = true }
                            .disabled(connection.isListEmpty)
                        TrailingButtonSFSymbol("waveform.path.badge.plus") { self.addRandom() }
                        TrailingButtonSFSymbol("text.badge.plus") {
                            withAnimation {
                                self.modal = .samples
                                self.showModal = true }}})
                    .actionSheet(isPresented: $showAction) {
                        ActionSheet(title: Text("Delete all?".uppercased()),
                                    message: Text("Are you 100% sure you want to delete all \("Ports")?\nYou can't undo this action."),
                                    buttons: [
                                        .cancel(),
                                        .destructive(Text("Yes, delete all")) {
                                            self.deleteAll()
                                        }])}
                    .sheet(isPresented: self.$showModal) {
                        if self.modal == .samples {
                            PortSampleList(connection: self.$draft)
                                .environmentObject(self.userData) }}
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        if connection == draft {
            presentation.wrappedValue.dismiss()
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if userData.restaurant.network.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.network.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.network.update(connection, with: draft) {
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

struct ConnectionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionDetail(connection: sampleConnections[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
