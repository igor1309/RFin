//
//  ConnectionList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ConnectionList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .samples
    
    private var connections: [Connection] { userData.restaurant.network.connections }
    
    var body: some View {
        List {
            if userData.restaurant.network.isListEmpty {
                Group {
                    Text("about Network").foregroundColor(.systemTeal)
                    Text("Tapping \("Connection")").foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            
            if !connections.filter({ $0.isOn }).isEmpty {
                Section(header: Text("On".uppercased()),
                        footer: Text("Some comment.")) {
                            ForEach(connections.filter{ $0.isOn }, id: \.self) { connection in
                                ConnectionRow(connection: connection)
                            }
                }
            }
            
            if !connections.filter({ !$0.isOn }).isEmpty {
                Section(header: Text("Off".uppercased()),
                        footer: Text("Some comment.")) {
                            ForEach(connections.filter{ !$0.isOn }, id: \.self) { connection in
                                ConnectionRow(connection: connection)
                            }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Connections")
        .navigationBarItems(
            leading: LeadingButton("Done") { self.presentation.wrappedValue.dismiss() },
            trailing: HStack {
                TrailingButtonSFSymbol("trash") { self.showAction = true }
                    .disabled(userData.restaurant.network.isListEmpty)
                TrailingButtonSFSymbol("waveform.path.badge.plus") { self.addRandom() }
                TrailingButtonSFSymbol("text.badge.plus") {
                    withAnimation {
                        self.modal = .samples
                        self.showModal = true }}})
            .actionSheet(isPresented: $showAction) {
                ActionSheet(title: Text("Delete all?".uppercased()),
                            message: Text("Are you 100% sure you want to delete all \("Connectins")?\nYou can't undo this action."),
                            buttons: [
                                .cancel(),
                                .destructive(Text("Yes, delete all")) {
                                    self.deleteAll()
                                }])}
            .sheet(isPresented: self.$showModal) {
                if self.modal == .samples {
                    ConnectionSampleList()
                        .environmentObject(self.userData) }}
    }
    
    func addRandom() {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        withAnimation {
            userData.restaurant.network.addRandom()
        }
    }
    
    func deleteAll() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        withAnimation {
            userData.restaurant.network.reset()
        }
    }
}

struct ConnectionList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConnectionList()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
