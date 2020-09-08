//
//  FunnelRow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelRow: View {
    @EnvironmentObject var userData: UserData
    var funnel: Funnel
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            FunnelSubRow(funnel: funnel)
                .onTapGesture {
                    self.modal = .detail
                    self.showModal = true }
                .contextMenu {
                    Button(action: {
                        self.toggleOn(self.funnel)
                    }) {
                        HStack {
                            Text("Turn \(funnel.isRunning ? "Off" : "On")")
                            Image(systemName: funnel.isRunning ? "xmark.circle" : "checkmark.circle")
                        }
                    }
                    Button(action: {
                        self.modal = .detail
                        self.showModal = true
                    }) {
                        HStack {
                            Text("Show/Edit \("Funnel")")
                            Image(systemName: "aspectratio")
                        }
                    }
                    Button(action: {
                        self.duplicate(self.funnel)
                    }) {
                        HStack {
                            Text("Duplicate \("Funnel")")
                            Image(systemName: "plus.square.on.square")
                        }
                    }
                    Button(action: {
                        self.showAlert = true
                    }) {
                        HStack {
                            Text("Delete \("Funnel")")
                            Image(systemName: "trash.circle")
                        }
                    }
                    .actionSheet(isPresented: $showAlert) {
                        ActionSheet(title: Text("Delete this \("Funnel?")".uppercased()),
                                    message: Text("You can't undo this action."),
                                    buttons: [
                                        .cancel(),
                                        .destructive(Text("Yes, delete it")) { self.delete() } ])}}
                
                .sheet(isPresented: $showModal) {
                    FunnelDetail(funnel: self.funnel, isNew: false)
                        .environmentObject(self.userData) }
        }
    }
    
    func toggleOn(_ funnel: Funnel) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        if userData.restaurant.channel.toggleRunning(funnel) {
            generator.impactOccurred()
        }
    }
    
    func duplicate(_ funnel: Funnel) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.channel.duplicate(funnel)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.channel.delete(funnel) {
                generator.impactOccurred()
            }
        }
    }
}

struct FunnelRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                FunnelRow(funnel: sampleFunnels[0])
                FunnelRow(funnel: sampleFunnels[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
