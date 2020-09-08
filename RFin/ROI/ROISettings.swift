//
//  ROISettings.swift
//  ROIColllection
//
//  Created by Igor Malyarov on 12.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ROISettings: View {
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
                        footer: Text("add or replace \("ROIs")")) {
                            
                            Button("Add all sample data") {
                                self.addAllSampleData()
                            }
                            
                            Button("Replace with Sample Data") {
                                self.showAction2 = true
                            }
                            .foregroundColor(.systemRed)
                            .actionSheet(isPresented: $showAction2) {
                                ActionSheet(title: Text("REPLACE WITH SAMPLES"),
                                            message: Text("replace with samples \("ROIs")"),
                                            buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, replace all")) {
                                                    self.replaceWithSampleData()
                                                }])}
                }
                
                Section(header: Text("RESET").padding(.top, 64),
                        footer: Text("can delete all \("ROIs")")) {
                            
                            Button("Delete all all ROIs") {
                                self.showAction = true
                            }
                            .foregroundColor(userData.roiCollection.otbivki.isEmpty ? .secondary : .systemRed)
                            .disabled(userData.roiCollection.otbivki.isEmpty)
                            .actionSheet(isPresented: $showAction) {
                                ActionSheet(title: Text("Delete all?".uppercased()),
                                            message: Text("Are you 100% sure you want to delete all \("ROIs")?\nYou can't undo this action."), buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, delete all")) {
                                                    self.deleteAll()
                                                    self.presentation.wrappedValue.dismiss()
                                                }])}
                }
            }
            .navigationBarTitle("Settings")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
        }
    }
    
    func addAllSampleData() {
        userData.roiCollection.addAllSampleData()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        self.presentation.wrappedValue.dismiss()
    }
    
    func replaceWithSampleData() {
        userData.roiCollection.replaceWithSampleData()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        self.presentation.wrappedValue.dismiss()
    }
    
    func deleteAll() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        withAnimation {
            userData.roiCollection.reset()
        }
    }
}

struct ROISettings_Previews: PreviewProvider {
    static var previews: some View {
        ROISettings()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
