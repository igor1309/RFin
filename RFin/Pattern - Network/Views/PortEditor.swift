//
//  PortEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortEditor: View {
    @Binding var draft: Port
    
    var body: some View {
        Form {
            Section(header: Text("Port Details"),
                    footer: Text("")) {
                        
                        TextFieldWithReset("Name", text: $draft.name)
                        TextFieldWithReset("Description", text: $draft.description)

                        CustomToggle(title: "Port Status", isOn: $draft.isOn)

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

struct PortEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PortEditor(draft: .constant(sampleConnections[0].ports[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
