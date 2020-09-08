//
//  ConnectionSubRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ConnectionSubRow: View {
    @EnvironmentObject var userData: UserData
    var connection: Connection
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            ListRow2(title: connection.name,
                     subtitle: connection.description,
                     detail: connection.isOn ? "ON" : "OFF",
                     active: connection.isOn,
                     full: true)
                .contentShape(Rectangle())
        }
    }
}

struct ConnectionSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ConnectionSubRow(connection: sampleConnections[0])
                ConnectionSubRow(connection: sampleConnections[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
