//
//  LevelDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct LevelDetail: View {
    @Environment(\.presentationMode) var presentation
    @Binding var funnel: Funnel
    var level: Level
    var isNew: Bool
    @State private var draft: Level
    @State private var isNameUsed = false
    
    init(funnel: Binding<Funnel>, level: Level, isNew: Bool) {
        self._funnel = funnel
        self.level = level
        self._draft = State(initialValue: level)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            LevelEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(leading:
                    LeadingButton("Done") { self.saveAndDismiss() }
                        .disabled(draft.name.isEmpty))
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        if level == draft {
            presentation.wrappedValue.dismiss()
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if funnel.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            funnel.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if funnel.update(level, with: draft) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
}

struct LevelDetail_Previews: PreviewProvider {
    static var previews: some View {
        LevelDetail(funnel: .constant(sampleFunnels[0]),
                   level: sampleFunnels[0].levels[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
