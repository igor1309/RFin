//
//  ConnectionSampleList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ConnectionSampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("Connection")")) {
                    Button("Add all Sample \("Connections")") { self.showAction = true }
                }
                
                Section(header: Text("Sample Connections".uppercased()),
                        footer: Text("Selected sample would be used to create a new entry to your Connections.")) {
                            ForEach(sampleConnections, id: \.self) { connection in
                                ConnectionSampleRow(connection: connection)
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.addSelected(connection: connection) }
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Sample")
                
            .navigationBarItems(leading: LeadingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
                
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("ADD ALL SAMPLES"),
                                message: Text("all samples confirmation"),
                                buttons: [
                                    .cancel(),
                                    .default(Text("Yes, add all samples")) {
                                        self.addAllSampleData() }])}
        }
    }
    
    func addAllSampleData() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        userData.restaurant.network.addAllSampleData()
        presentation.wrappedValue.dismiss()
    }
    
    func addSelected(connection: Connection) {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        withAnimation {
            userData.restaurant.network.add(connection)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct ConnectionSampleList_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionSampleList()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
