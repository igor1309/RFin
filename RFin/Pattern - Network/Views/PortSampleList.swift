//
//  PortSampleList.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PortSampleList: View {
    @Environment(\.presentationMode) var presentation
    @Binding var connection: Connection
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("Port")")) {
                    Button("Add all Sample \("Ports")") { self.showAction = true }
                }
                
                Section(header: Text("Sample Connections"),
                        footer: Text("Selected sample would be used to create a new entry to your Connections.")) {
                            ForEach(sampleConnections[0].ports, id: \.self) { port in
                                PortSampleRow(connection: self.$connection,
                                              port: port)
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.addSelected(port: port) }
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Sample")
                
            .navigationBarItems(leading: LeadingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
                
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
        connection.addAllSampleData()
        presentation.wrappedValue.dismiss()
    }
    
    func addSelected(port: Port) {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        withAnimation {
            connection.add(port)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct PortSampleList_Previews: PreviewProvider {
    static var previews: some View {
        PortSampleList(connection: .constant(sampleConnections[0]))
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
