//
//  ScenarioOptions.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ScenarioOptions: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    //    @EnvironmentObject var settings: SettingsStore
    
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("Scenario")")) {
                    Button("Add all Samples \("Scenario")") { self.showAction = true }
                }
                
                Section(header: Text("Select Investors's Share:".uppercased()),
                        footer: Text("Selected sample would be used to create a new entry to your Scenarios.")) {
                            ForEach(sampleOptions, id: \.self) { option in
                                SampleOptionRow(otbivka: option.otbivka)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        self.addSelected(option: option)
                                        self.presentation.wrappedValue.dismiss()
                                }
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Sample")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
                
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("ADD ALL SAMPLES"), message: Text("all samples confirmation"), buttons: [
                        .cancel(),
                        .default(Text("Yes, add all samples")) {
                            self.addAllSampleData() }])}
        }
    }
    
    func addAllSampleData() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        userData.scenario.addAllSampleData()
        self.presentation.wrappedValue.dismiss()
    }
    
    func addSelected(option: Option) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        withAnimation {
            userData.scenario.add(option)
        }
        self.presentation.wrappedValue.dismiss()
    }
}

struct ScenarioOptions_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioOptions()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
