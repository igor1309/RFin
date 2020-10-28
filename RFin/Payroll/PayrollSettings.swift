//
//  PayrollSettings.swift
//  Payroll
//
//  Created by Igor Malyarov on 04.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI
import CoreHaptics

struct TextFieldWithCommit: View {
    @Binding var name: String
    @State private var draftName: String
    @State private var showRename: Bool
    
    init(name: Binding<String>) {
        self._name = name
        self._draftName = State(initialValue: name.wrappedValue)
        self._showRename = State(initialValue: false)
    }
    
    var body: some View {
        Group {
            if showRename {
                HStack {
                    TextField("Version Name", text: $draftName)
                    Button(action: {
                        //  MARK: FINISH THIS
                        
                        self.name = self.draftName
                        self.showRename = false
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                    .disabled(draftName.isEmpty || draftName == name)
                }
            } else {
                Button("Rename Version") {
                    //  MARK: FINISH THIS
                    
                    self.showRename = true
                }
            }
        }
    }
}

struct PayrollSettings: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @Binding var staff: Staff
    @State private var draftName: String
    @State private var showRename: Bool
    @State private var showActionReplace: Bool
    @State private var showActionReset: Bool
    
    init(staff: Binding<Staff>) {
        self._staff = staff
        self._draftName = State(initialValue: staff.wrappedValue.name)
        self._showRename = State(initialValue: false)
        self._showActionReplace = State(initialValue: false)
        self._showActionReset = State(initialValue: false)
    }
    
    var isListEmpty: Bool { staff.positions.isEmpty }
    var hapticsAvailable: Bool { CHHapticEngine.capabilitiesForHardware().supportsHaptics }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Rename"),
                        footer: Text("Rename current Staff Version.")) {
                            Group {
                            if showRename {
                                HStack {
                                    TextField("Version Name", text: $draftName)
                                    Button(action: {
                                        //  MARK: FINISH THIS
                                        
                                        if self.hapticsAvailable {
                                            let generator = UIImpactFeedbackGenerator(style: .light)
                                            generator.impactOccurred()
                                        }
                                        
                                        self.staff.name = self.draftName
                                        self.showRename = false
                                    }) {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.accentColor)
                                    }
                                    .disabled(draftName.isEmpty || draftName == staff.name)
                                }
                            } else {
                                Button("Rename Version") {
                                    //  MARK: FINISH THIS
                                    
                                    self.showRename = true
                                }
                            }
                            }
                }
                
                Section(header: Text("SAMPLES"),
                        footer: Text("You can replace your Staff with sample data.")) {
                            
                            Button("Replace with Sample Data") {
                                self.showActionReplace = true
                            }
                            .foregroundColor(.systemRed)
                            .actionSheet(isPresented: $showActionReplace) {
                                ActionSheet(title: Text("REPLACE WITH SAMPLES"),
                                            message: Text("Do you really want to replace all Staff Positions with sample data?\nThis could not be undone."),
                                            buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, replace all")) {
                                                    self.replaceWithSampleData()
                                                }])}
                }
                
                Section(header: Text("RESET"),
                        footer: Text("can delete all \("Staff positions")")) {
                            
                            Button("Reset Staff") {
                                self.showActionReset = true
                            }
                            .foregroundColor(isListEmpty ? .secondary : .systemRed)
                            .disabled(isListEmpty)
                            .actionSheet(isPresented: $showActionReset) {
                                ActionSheet(title: Text("Delete all?".uppercased()),
                                            message: Text("Are you 100% sure you want to delete all Staff Positions?\nYou can't undo this action."), buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, delete all")) {
                                                    self.deleteAll()
                                                    self.presentation.wrappedValue.dismiss()
                                                }])}
                }
            }
            .navigationBarTitle(staff.name)
            //.navigationBarTitle("Payroll Settings")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
        }
    }
    
    func rename() {
        userData.restaurant.staffVersions.rename(staff: staff, newName: draftName)

        if self.hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    func deleteAll() {
        if self.hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        }
        withAnimation {
            staff.reset()
        }
    }
    
    func replaceWithSampleData() {
        staff.replaceWithSampleData()
        if self.hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        }
        self.presentation.wrappedValue.dismiss()
    }
}

struct PayrollSettings_Previews: PreviewProvider {
    static var previews: some View {
        PayrollSettings(staff: .constant(sampleStaff))
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
