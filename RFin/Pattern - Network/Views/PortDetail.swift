//
//  PortDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PortDetail: View {
    @Environment(\.presentationMode) var presentation
    @Binding var connection: Connection
    var port: Port
    var isNew: Bool
    @State private var draft: Port
    @State private var isNameUsed = false
    
    init(connection: Binding<Connection>, port: Port, isNew: Bool) {
        self._connection = connection
        self.port = port
        self._draft = State(initialValue: port)
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationView {
            PortEditor(draft: $draft)
                .navigationBarTitle(draft.name)
                .navigationBarItems(trailing:
                    TrailingButton("Done") { self.saveAndDismiss() }
                        .disabled(draft.name.isEmpty))
        }
    }
    
    func saveAndDismiss() {
        if draft.name.isEmpty { return }
        
        if port == draft {
            presentation.wrappedValue.dismiss()
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        //  make sure name isn't used twice
        if connection.isNameUsed(draft) {
            isNameUsed = true
            generator.notificationOccurred(.error)
            print("NAME IS USED")
            return
        }
        
        if isNew {
            generator.notificationOccurred(.success)
            connection.add(draft)
            self.presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if connection.update(port, with: draft) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
}

struct PortDetail_Previews: PreviewProvider {
    static var previews: some View {
        PortDetail(connection: .constant(sampleConnections[0]),
                   port: sampleConnections[0].ports[0], isNew: false)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
