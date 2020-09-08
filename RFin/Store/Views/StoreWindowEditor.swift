//
//  StoreWindowEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct StoreWindowEditor: View {
    @Binding var draft: StoreWindow
    
    var body: some View {
        Form {
            Section(
                header: Text("StoreWindow Details"),
                footer: Text("")
            ) {
                
                TextFieldWithReset("Name", text: $draft.name)
                TextFieldWithReset("Description", text: $draft.description)
                
                CustomToggle(title: "StoreWindow Status", isOn: $draft.isOn)
            }
            
            if !draft.shelfs.isEmpty {
                Section(
                    header: Text("Shelfs"),
                    footer: Text("Some Footer.")
                ) {
                    ForEach(draft.shelfs, id: \.self) { shelf in
                        ShelfRow(storeWindow: $draft, shelf: shelf)
                    }
                }
            }
        }
    }
}

struct StoreWindowEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StoreWindowEditor(draft: .constant(sampleStoreWindows[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
