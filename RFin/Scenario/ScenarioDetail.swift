//
//  ScenarioDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ScenarioDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    let option: Option
    let isNew: Bool
    
    init(option: Option, isNew: Bool) {
        self.option = option
        self.isNew = isNew
        _draft = State(initialValue: option)
    }
    
    @State private var draft: Option
    @State private var showModal = false
    @State private var modal: ModalType = .settings
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Investor's Share"),
                    footer: Text("Profit sharing between")
                ) {
                    Group {
                        Stepper(value: $draft.investorsShareBeforeReturn, in: 0...1, step: 0.05) {
                            HStack {
                                Label("Before Return", systemImage: "square.fill.and.line.vertical.and.square")
                                Spacer()
                                Text(draft.investorsShareBeforeReturn.formattedPercentage)
                                    .foregroundColor(.systemOrange)
                            }
                        }
                        .contextMenu {
                            Button {
                                draft.investorsShareBeforeReturn = 1.0
                            } label: {
                                Label(1.0.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareBeforeReturn = 0.9
                            } label: {
                                Label(0.9.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareBeforeReturn = 0.80
                            } label: {
                                Label(0.80.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareBeforeReturn = 0.75
                            } label: {
                                Label(0.75.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareBeforeReturn = 0.50
                            } label: {
                                Label(0.50.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                        }
                        
                        Stepper(value: $draft.investorsShareAfterReturn, in: 0...1, step: 0.05) {
                            HStack {
                                Label("After Return", systemImage: "square.and.line.vertical.and.square.fill")
                                Spacer()
                                Text(draft.investorsShareAfterReturn.formattedPercentage)
                                    .foregroundColor(.systemOrange)
                            }
                        }
                        .contextMenu {
                            Button {
                                draft.investorsShareAfterReturn = 1.0
                            } label: {
                                Label(1.0.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareAfterReturn = 0.7
                            } label: {
                                Label(0.7.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareAfterReturn = 0.65
                            } label: {
                                Label(0.65.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareAfterReturn = 0.6
                            } label: {
                                Label(0.6.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                            Button {
                                draft.investorsShareAfterReturn = 0.50
                            } label: {
                                Label(0.50.formattedPercentage, systemImage: "arrow.uturn.left.square")
                            }
                        }
                    }
                    .font(.subheadline)
                }
                
                Section(header: Text("Calculations")) {
                    ScenarioRow(option: draft)
                }
                
                ROIDetailFlowsSection(otbivka: option.otbivka)
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Scenario Option")
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("gear") {
                    modal = .settings
                    showModal = true },
                trailing: TrailingButton("Done") {
                    saveAndDismiss()
                }
            )
            .sheet(isPresented: $showModal) {
                if modal == .settings {
                    ScenarioSettings()
                        .environmentObject(userData)
                        .environmentObject(settings) }}
        }
    }
    
    private func saveAndDismiss() {
        let generator = UINotificationFeedbackGenerator()
        
        if isNew {
            generator.notificationOccurred(.success)
            userData.scenario.add(draft)
            presentation.wrappedValue.dismiss()
            print("NEW ELEMENT ADDED")
            return
        }
        
        if userData.scenario.update(option, with: draft) {
            generator.notificationOccurred(.success)
            presentation.wrappedValue.dismiss()
            print("ELEMENT UPDATED SUCCESSFULLY")
        } else {
            generator.notificationOccurred(.error)
            print("ERROR UPDATING ELEMENT")
        }
    }
}

struct ScenarioDetail_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioDetail(option: sampleOptions[0], isNew: false)
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
