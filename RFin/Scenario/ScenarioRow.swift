//
//  ScenarioRow.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ScenarioRow: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var option: Option
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack {
            ROISplit2(otbivka: option.otbivka)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.modal = .detail
            self.showModal = true }
            
            .contextMenu {
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Edit \("Scenario")")
                        Image(systemName: "pencil.and.outline")
                    }
                }
                .sheet(isPresented: $showModal) {
                    if self.modal == .detail {
                        ScenarioDetail(option: self.option, isNew: false)
                            .environmentObject(self.userData)
                            .environmentObject(self.settings) }}
                
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("Scenario")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("Scenario")?".uppercased()),
                                message: Text("can't delete"),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.scenario.delete(option) {
                generator.impactOccurred()
            }
        }
    }
}

struct ScenarioRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ScenarioRow(option: sampleOptions[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
