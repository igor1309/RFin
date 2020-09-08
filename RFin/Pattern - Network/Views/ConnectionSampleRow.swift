//
//  ConnectionSampleRow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ConnectionSampleRow: View {
    var connection: Connection
    
    var body: some View {
        ConnectionSubRow(connection: connection)
    }
}

struct ConnectionSampleRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ConnectionSampleRow(connection: sampleConnections[0])
                ConnectionSampleRow(connection: sampleConnections[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
