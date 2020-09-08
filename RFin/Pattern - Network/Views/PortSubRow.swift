//
//  PortSubRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortSubRow: View {
    @Binding var connection: Connection
    var port: Port
    @State private var showModal = false
    
    var body: some View {
        ListRow2(title: port.name,
                 subtitle: port.description,
                 detail: port.number.formattedFlat,
                 active: port.isOn)
            .foregroundColor(port.isOn ? .primary : .secondary)
            .contentShape(Rectangle())
    }
}

struct PortSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PortSubRow(connection: .constant(sampleConnections[0]),
                port: sampleConnections[0].ports[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
