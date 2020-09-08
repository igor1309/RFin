//
//  ShelfDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ShelfDetail: View {
    @Environment(\.presentationMode) var presentation
    @Binding var storeWindow: StoreWindow
    var shelf: Shelf
    var isNew: Bool
    @State private var draft: Shelf
    @State private var isNameUsed = false
    
    init(storeWindow: Binding<StoreWindow>, shelf: Shelf, isNew: Bool) {
        self._storeWindow = storeWindow
        self.shelf = shelf
        self._draft = State(initialValue: shelf)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            ShelfEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(trailing:
                    TrailingButton("Done") { self.saveAndDismiss() }
                        .disabled(draft.name.isEmpty))
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        if shelf == draft {
            presentation.wrappedValue.dismiss()
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if storeWindow.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            storeWindow.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if storeWindow.update(shelf, with: draft) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
}

struct ShelfDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShelfDetail(storeWindow: .constant(sampleStoreWindows[0]),
                   shelf: sampleStoreWindows[0].shelfs[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
