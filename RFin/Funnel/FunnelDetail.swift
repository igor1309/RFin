//
//  FunnelDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct FunnelDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var funnel: Funnel
    var isNew: Bool
    @State private var draft: Funnel
    @State private var isNameUsed = false
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .samples
    
    init(funnel: Funnel, isNew: Bool) {
        self.funnel = funnel
        self._draft = State(initialValue: funnel)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            FunnelEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(
                    leading: LeadingButton("Done") { self.saveAndDismiss() }
                        .disabled(draft.name.isEmpty),
                    trailing: HStack {
                        TrailingButtonSFSymbol("trash") { self.showAction = true }
                            .disabled(funnel.isListEmpty)
                        TrailingButtonSFSymbol("waveform.path.badge.plus") { self.addRandom() }
                        TrailingButtonSFSymbol("text.badge.plus") {
                            withAnimation {
                                self.modal = .samples
                                self.showModal = true }}})
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("Delete all?".uppercased()),
                                message: Text("Are you 100% sure you want to delete all \("Levels")?\nYou can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete all")) {
                                        self.deleteAll()
                                    }])}
                .sheet(isPresented: self.$showModal) {
                    if self.modal == .samples {
                        LevelSampleList(funnel: self.$draft)
                            .environmentObject(self.userData) }}
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        if funnel == draft {
            presentation.wrappedValue.dismiss()
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if userData.restaurant.channel.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.restaurant.channel.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.restaurant.channel.update(funnel, with: draft) {
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

struct FunnelDetail_Previews: PreviewProvider {
    static var previews: some View {
        FunnelDetail(funnel: sampleFunnels[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
            .previewLayout(.fixed(width: 343, height: 1500))
    }
}
