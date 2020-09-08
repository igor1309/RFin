//
//  QuickPLDetail.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct QuickPLDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var quickPL: QuickPL
    var isNew: Bool
    
    @State private var draft: QuickPL
    
    init(quickPL: QuickPL, isNew: Bool) {
        self.quickPL = quickPL
        self._draft = State(initialValue: quickPL)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            QuickPLDetailEditor(draft: $draft)
                
                .navigationBarTitle("Quick P&L")
                
                .navigationBarItems(trailing: TrailingButton("Done") {
                    self.saveAndDismiss()
                })
        }
    }
    
    private func saveAndDismiss() {
        let generator = UINotificationFeedbackGenerator()
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.quickie.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.quickie.update(quickPL, with: draft) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
}

struct QuickPLDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuickPLDetail(quickPL: sampleQuickie.quickPLs[0], isNew: false)
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
