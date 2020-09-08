//
//  ScenarioList.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ScenarioList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showModifySection = false
    @State private var showModal = false
    @State private var modal: ModalType = .settings
    
    var isListEmpty: Bool { userData.scenario.isEmpty }
    
    var body: some View {
        NavigationView {
            List {
                Text("aboutScenarios \(showModifySection ? "Tap to hide options." : "Tap for options.")")
                    .font(.footnote)
                    .foregroundColor(isListEmpty ? .systemTeal : .secondary)
                    .onTapGesture {
                        withAnimation {
                            showModifySection.toggle()
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                        }}
                
                if showModifySection {
                    ScenarioModityQuickPL(scenario: $userData.scenario)
                }
                
                Section(header: Text("Quick P&L"),
                        footer: Text("ice")){
                    
                    QuickPLSubRow(quickPL: userData.scenario.quickPL)
                }
                
                if isListEmpty {
                    Text("Tapping \("Scenario")")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                ForEach(userData.scenario.options, id: \.self) { option in
                    
                    Section(
                        header: Text("Scenario \(userData.scenario.options.firstIndex(of: option)! + 1)")
                    ) {
                        ScenarioRow(option: option)
                            .contentShape(Rectangle())
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Scenarios")
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("gear") {
                    modal = .settings
                    showModal = true },
                trailing:
                    HStack {
                        TrailingButtonSFSymbol("waveform.path.badge.plus") {
                            addNewRandomOption()
                        }
                        TrailingButtonSFSymbol("text.badge.plus") {
                            modal = .samples
                            showModal = true
                        }
                    }
            )
            .sheet(isPresented: $showModal) {
                if modal == .settings {
                    ScenarioSettings()
                        .environmentObject(userData)
                        .environmentObject(settings)
                }
                
                if modal == .samples {
                    ScenarioOptions()
                        .environmentObject(userData)
                        .environmentObject(settings)
                }
            }
        }
    }
    
    func addNewRandomOption() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.scenario.addRandomOption()
        }
    }
    
    func delete(at offsets: IndexSet) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        withAnimation {
            userData.scenario.options.remove(atOffsets: offsets)
        }
    }
}

struct ScenarioList_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioList()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
