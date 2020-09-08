//
//  ConnectionEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ConnectionEditor: View {
    @Binding var draft: Connection
    
    var body: some View {
        Form {
            Section(header: Text("Connection Details".uppercased()),
                    footer: Text("")) {
                        
                        TextFieldWithReset("Name", text: $draft.name)
                        TextFieldWithReset("Description", text: $draft.description)
                        
                        CustomToggle(title: "Connection Status", isOn: $draft.isOn)
            }
            
            if !draft.ports.isEmpty {
                Section(header: Text("Ports".uppercased()), footer: Text("Some Footer.")) {
                    ForEach(draft.ports, id: \.self) { port in
                        PortRow(connection: self.$draft, port: port)
                    }
                }
            }
        }
    }
}

struct ConnectionEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConnectionEditor(draft: .constant(sampleConnections[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
