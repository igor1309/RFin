//
//  FunnelList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct FunnelList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @State private var showAction = false
    @State private var showModal = false
    @State private var modal: ModalType = .samples
    
    private var funnels: [Funnel] { userData.restaurant.channel.funnels }
    
    let footer = Text("Number of Sales (guests) and Cost per Sale (CPS; also Cost per guest).")
        + Text("\nChange On/Off via context menu, tap to edit.").italic()
    
    var body: some View {
        List {
            if userData.restaurant.channel.isListEmpty {
                Group {
                    Text("about Channel").foregroundColor(.systemTeal)
                    Text("Tapping \("Funnel")").foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            
            if !funnels.filter({ $0.isRunning }).isEmpty {
                Section(header: Text("On".uppercased()),
                        footer: footer) {
                            ForEach(funnels.filter{ $0.isRunning }, id: \.self) { funnel in
                                FunnelRow(funnel: funnel)
                            }
                }
            }
            
            if !funnels.filter({ !$0.isRunning }).isEmpty {
                Section(header: Text("Off".uppercased()),
                        footer: Text("Change On/Off via context menu, tap to edit.")) {
                            ForEach(funnels.filter{ !$0.isRunning }, id: \.self) { funnel in
                                FunnelRow(funnel: funnel)
                            }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Funnels")
        .navigationBarItems(
            leading: LeadingButton("Done") { self.presentation.wrappedValue.dismiss() },
            trailing: HStack {
                TrailingButtonSFSymbol("trash") { self.showAction = true }
                    .disabled(userData.restaurant.channel.isListEmpty)
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
                    FunnelSampleList()
                        .environmentObject(self.userData) }}
    }
    
    func addRandom() {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        withAnimation {
            userData.restaurant.channel.addRandom()
        }
    }
    
    func deleteAll() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        withAnimation {
            userData.restaurant.channel.reset()
        }
    }
}

struct FunnelList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FunnelList()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
