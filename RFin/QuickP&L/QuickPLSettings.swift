//
//  QuickPLSettings.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 12.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct QuickPLSettings: View {
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
                        footer: Text("add or replace \("Quick P&Ls")")) {
                            
                            Button("Add all sample data") {
                                self.addAllSampleData()
                            }
                            
                            Button("Replace with Sample Data") {
                                self.showAction2 = true
                            }
                            .foregroundColor(.systemRed)
                            .actionSheet(isPresented: $showAction2) {
                                ActionSheet(title: Text("replace with samples \("Quick P&Ls")"),
                                            buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, replace all")) {
                                                    self.replaceWithSampleData()
                                                }])}
                }
                
                Section(header: Text("RESET").padding(.top, 64),
                        footer: Text("can delete all \("Quick P&Ls")")) {
                            
                            Button("Delete all Quick P&Ls") {
                                self.showAction = true
                            }
                            .foregroundColor(userData.quickie.quickPLs.isEmpty ? .secondary : .systemRed)
                            .disabled(userData.quickie.quickPLs.isEmpty)
                            .actionSheet(isPresented: $showAction) {
                                ActionSheet(title: Text("Delete all?".uppercased()),
                                            message: Text("Are you 100% sure you want to delete all rows?\nYou can't undo this action."), buttons: [
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
        userData.quickie.addAllSampleData()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        self.presentation.wrappedValue.dismiss()
    }
    
    func replaceWithSampleData() {
        userData.quickie.replaceWithSampleData()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        self.presentation.wrappedValue.dismiss()
    }
    
    func deleteAll() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        withAnimation {
            userData.quickie.reset()
        }
    }
}

struct QuickPLSettings_Previews: PreviewProvider {
    static var previews: some View {
        QuickPLSettings()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
