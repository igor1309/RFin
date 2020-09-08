//
//  PortSampleRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortSampleRow: View {
    @Binding var connection: Connection
    var port: Port

    var body: some View {
        PortSubRow(connection: .constant(sampleConnections[0]), port: port)
    }
}

struct PortSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PortSampleRow(connection: .constant(sampleConnections[0]),
                              port: sampleConnections[0].ports[0])
                PortSampleRow(connection: .constant(sampleConnections[0]),
                              port: sampleConnections[0].ports[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
