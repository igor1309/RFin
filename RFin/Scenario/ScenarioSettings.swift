//
//  ScenarioSettings.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ScenarioSettings: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @State private var showAction = false
    @State private var showAction2 = false
    
    var body: some View {
        NavigationView {
            Form {
                GlobalSettings()
                
                Section(header: Text("SAMPLES"),
                        footer: Text("add or replace \("Scenarios")")) {
                            Button("Add all sample data") {
                                self.addAllSampleData()
                            }
                            
                            Button("Replace with Sample Data") {
                                self.showAction2 = true
                            }
                            .foregroundColor(.systemRed)
                            .actionSheet(isPresented: $showAction2) {
                                ActionSheet(title: Text("REPLACE WITH SAMPLES"),
                                            message: Text("replace with samples \("Scenarios")"),
                                            buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, replace all")) {
                                                    self.replaceWithSampleData()
                                                }])}
                }
                
                Section(header: Text("RESET").padding(.top, 64),
                        footer: Text("can delete all \("Scenarios")")) {
                            Button("Delete all Scenarios") {
                                self.showAction = true
                            }
                            .foregroundColor(userData.scenario.options.isEmpty ? .secondary : .systemRed)
                            .disabled(userData.scenario.options.isEmpty)
                            .actionSheet(isPresented: $showAction) {
                                ActionSheet(title: Text("Delete all?".uppercased()),
                                            message: Text("Are you 100% sure you want to delete all Scenarios?\nYou can't undo this action."), buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, delete all")) {
                                                    self.deleteAll()
                                                    self.presentation.wrappedValue.dismiss() }])}
                }
            }
            .navigationBarTitle("Settings")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
    
    func addAllSampleData() {
        userData.scenario.addAllSampleData()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        self.presentation.wrappedValue.dismiss()
    }
    
    func replaceWithSampleData() {
        userData.scenario.replaceWithSampleData()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        self.presentation.wrappedValue.dismiss()
    }
    
    func deleteAll() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        withAnimation {
            userData.scenario.reset()
        }
    }
}

struct ScenarioSettings_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioSettings()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
