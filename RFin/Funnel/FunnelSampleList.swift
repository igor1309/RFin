//
//  FunnelSampleList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct FunnelSampleList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("Funnel")")) {
                    Button("Add all Sample \("Funnels")") { self.showAction = true }
                }
                
                Section(header: Text("Sample Funnels".uppercased()),
                        footer: Text("Selected sample would be used to create a new entry to your Funnels.")) {
                            ForEach(sampleFunnels, id: \.self) { funnel in
                                FunnelSampleRow(funnel: funnel)
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.addSelected(funnel: funnel) }
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
        userData.restaurant.channel.addAllSampleData()
        presentation.wrappedValue.dismiss()
    }
    
    func addSelected(funnel: Funnel) {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        withAnimation {
            userData.restaurant.channel.add(funnel)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct FunnelSampleList_Previews: PreviewProvider {
    static var previews: some View {
        FunnelSampleList()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
