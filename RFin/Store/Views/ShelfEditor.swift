//
//  ShelfEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ShelfEditor: View {
    @Binding var draft: Shelf
    
    var body: some View {
        Form {
            Section(header: Text("Shelf Details".uppercased()),
                    footer: Text("")) {
                        
                        TextFieldWithReset("Name", text: $draft.name)
                        TextFieldWithReset("Description", text: $draft.description)

                        CustomToggle(title: "Shelf Status", isOn: $draft.isOn)

                        Stepper(value: $draft.number) {
                            HStack {
                                Text("Number")
                                Spacer()
                                Text(draft.number.formattedFlat)
                                    .foregroundColor(.systemOrange)
                            }
                        }
            }
        }
    }
}

struct ShelfEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShelfEditor(draft: .constant(sampleStoreWindows[0].shelfs[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
