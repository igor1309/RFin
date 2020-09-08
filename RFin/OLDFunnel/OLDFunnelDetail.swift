//
//  OLDFunnelDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct OLDFunnelDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
//    var currency: Currency { userData.restaurant.currency }
    var funnel: Funnel
    var isNew: Bool
    @State private var draft: Funnel
    @State private var isNameUsed = false
    
    
    init(funnel: Funnel, isNew: Bool) {
        self.funnel = funnel
        self._draft = State(initialValue: funnel)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            OLDFunnelEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(trailing: TrailingButton("Done") { self.saveAndDismiss() }
                    .disabled(draft.name.isEmpty))
            
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
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
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
}

struct OLDFunnelDetail_Previews: PreviewProvider {
    static var previews: some View {
        OLDFunnelDetail(funnel: sampleFunnels[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
