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
    
    var option: Option
    var isNew: Bool
    
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
                                Image(systemName: "square.fill.and.line.vertical.and.square")
                                    .frame(minWidth: 28, alignment: .leading)
                                Text("Before Return")
                                Spacer()
                                Text(draft.investorsShareBeforeReturn.formattedPercentage)
                                    .foregroundColor(.systemOrange)
                            }
                        }
                        .contextMenu {
                            Button(action: {
                                draft.investorsShareBeforeReturn = 1.0
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(1.0.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareBeforeReturn = 0.9
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.9.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareBeforeReturn = 0.80
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.80.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareBeforeReturn = 0.75
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.75.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareBeforeReturn = 0.50
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.50.formattedPercentage)
                            }
                        }
                        
                        Stepper(value: $draft.investorsShareAfterReturn, in: 0...1, step: 0.05) {
                            HStack {
                                Image(systemName: "square.and.line.vertical.and.square.fill")
                                    .frame(minWidth: 28, alignment: .leading)
                                Text("After Return")
                                Spacer()
                                Text(draft.investorsShareAfterReturn.formattedPercentage)
                                    .foregroundColor(.systemOrange)
                            }
                        }
                        .contextMenu {
                            Button(action: {
                                draft.investorsShareAfterReturn = 1.0
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(1.0.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareAfterReturn = 0.7
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.7.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareAfterReturn = 0.65
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.65.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareAfterReturn = 0.6
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.6.formattedPercentage)
                            }
                            Button(action: {
                                draft.investorsShareAfterReturn = 0.50
                            }) {
                                Image(systemName: "arrow.uturn.left.square")
                                Text(0.50.formattedPercentage)
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
