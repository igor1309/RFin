//
//  ConnectionRow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ConnectionRow: View {
    @EnvironmentObject var userData: UserData
    var connection: Connection
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            ConnectionSubRow(connection: connection)
                .onTapGesture {
                    self.modal = .detail
                    self.showModal = true }
                .contextMenu {
                    Button(action: {
                        self.toggleOn(self.connection)
                    }) {
                        HStack {
                            Text("Turn \(connection.isOn ? "Off" : "On")")
                            Image(systemName: connection.isOn ? "xmark.circle" : "checkmark.circle")
                        }
                    }
                    Button(action: {
                        self.modal = .detail
                        self.showModal = true
                    }) {
                        HStack {
                            Text("Show/Edit \("Connection")")
                            Image(systemName: "aspectratio")
                        }
                    }
                    Button(action: {
                        self.duplicate(self.connection)
                    }) {
                        HStack {
                            Text("Duplicate \("Connection")")
                            Image(systemName: "plus.square.on.square")
                        }
                    }
                    Button(action: {
                        self.showAlert = true
                    }) {
                        HStack {
                            Text("Delete \("Connection")")
                            Image(systemName: "trash.circle")
                        }
                    }
                    .actionSheet(isPresented: $showAlert) {
                        ActionSheet(title: Text("Delete this \("Connection?")".uppercased()),
                                    message: Text("You can't undo this action."),
                                    buttons: [
                                        .cancel(),
                                        .destructive(Text("Yes, delete it")) { self.delete() } ])}}
                
                .sheet(isPresented: $showModal) {
                    ConnectionDetail(connection: self.connection, isNew: false)
                        .environmentObject(self.userData) }
        }
    }
    
    func toggleOn(_ connection: Connection) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        if userData.restaurant.network.toggleOn(connection) {
            generator.impactOccurred()
        }
    }
    
    func duplicate(_ connection: Connection) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.network.duplicate(connection)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.network.delete(connection) {
                generator.impactOccurred()
            }
        }
    }
}

struct ConnectionRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ConnectionRow(connection: sampleConnections[0])
                ConnectionRow(connection: sampleConnections[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
