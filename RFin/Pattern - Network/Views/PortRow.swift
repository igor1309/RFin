//
//  PortRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortRow: View {
    @Binding var connection: Connection
    var port: Port
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        PortSubRow(connection: $connection, port: port)
            .onTapGesture {
                self.modal = .detail
                self.showModal = true }
            .contextMenu {
                Button(action: {
                    self.toggleOn(self.port)
                }) {
                    HStack {
                        Text("Turn \(port.isOn ? "Off" : "On")")
                        Image(systemName: port.isOn ? "xmark.circle" : "checkmark.circle")
                    }
                }
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Show/Edit \("Port")")
                        Image(systemName: "aspectratio")
                    }
                }
                Button(action: {
                    self.duplicate(self.port)
                }) {
                    HStack {
                        Text("Duplicate \("Port")")
                        Image(systemName: "plus.square.on.square")
                    }
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("Port")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("Port?")".uppercased()),
                                message: Text("You can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
            
            .sheet(isPresented: $showModal) {
                PortDetail(connection: self.$connection, port: self.port, isNew: false) }
    }
    
    func toggleOn(_ port: Port) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        if connection.toggleOn(port) {
            generator.impactOccurred()
        }
    }
    
    func duplicate(_ port: Port) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            connection.duplicate(port)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if connection.delete(port) {
                generator.impactOccurred()
            }
        }
    }
}

struct PortRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PortRow(connection: .constant(sampleConnections[0]),
                        port: sampleConnections[0].ports[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
