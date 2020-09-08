//
//  ScenarioModityQuickPL.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ScenarioModityQuickPL: View {
    @Binding var scenario: Scenario
    
    var body: some View {
        Section(
            header: Text("Modify Quick P&L"),
            footer: Text("Use steppers above to modify Quick P&L.")
        ) {
            Group {
                Stepper(value: $scenario.investment, in: 300_000...50_000_000, step: 50_000) {
                    HStack {
                        Text("Investment")
                        Spacer()
                        Text(scenario.investment.formattedGrouped)
                            .foregroundColor(.systemOrange)
                    }
                    .contextMenu {
                        Button(action: {
                            scenario.investment = 400_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(400_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.investment = 500_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(500_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.investment = 600_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(600_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.investment = 650_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(650_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.investment = 30_000_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(30_000_000.formattedGrouped)
                        }}
                }
                
                Stepper(value: $scenario.noOfCoversPerWeek, in: 400...1500, step: 10) {
                    HStack {
                        Text("# of Covers per week")
                        Spacer()
                        Text(scenario.noOfCoversPerWeek.formattedGrouped)
                            .foregroundColor(.systemOrange)
                    }
                    .contextMenu {
                        Button(action: {
                            scenario.noOfCoversPerWeek = 480
                        }) {
                            HStack {
                                Text("480 covers per week")
                                Image(systemName: "arrow.counterclockwise.circle")
                            }
                        }
                        Button(action: {
                            scenario.noOfCoversPerWeek = 600
                        }) {
                            HStack {
                                Text("600 covers per week")
                                Image(systemName: "arrow.counterclockwise.circle")
                            }
                        }
                        Button(action: {
                            scenario.noOfCoversPerWeek = 720
                        }) {
                            HStack {
                                Text("720 covers per week")
                                Image(systemName: "arrow.counterclockwise.circle")
                            }
                        }}
                }
                .foregroundColor(.systemGreen)
                
                Stepper(value: $scenario.payrollRate, in: 30_000...80_000, step: 5_000) {
                    HStack {
                        Text("Payroll")
                        Spacer()
                        Text(scenario.payrollRate.formattedGrouped)
                            .foregroundColor(.systemOrange)
                    }
                    .contextMenu {
                        Button(action: {
                            scenario.payrollRate = 40_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(40_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.payrollRate = 50_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(50_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.payrollRate = 55_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(55_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.payrollRate = 60_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(60_000.formattedGrouped)
                        }
                        Button(action: {
                            scenario.payrollRate = 80_000
                        }) {
                            Image(systemName: "arrow.uturn.left.square")
                            Text(80_000.formattedGrouped)
                        }}
                }
                .foregroundColor(.systemPurple)
                
                Stepper(value: $scenario.estPeriodInMonths, in: 36...96, step: 6) {
                    HStack {
                        Text("Estimation Period")
                        Spacer()
                        Text((Double(scenario.estPeriodInMonths) / 12).formattedGroupedWithMax2Decimals + "y")
                            .foregroundColor(.systemOrange)
                    }
                }
            }
            .font(.subheadline)
        }
    }
}

struct ScenarioModityQuickPL_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ScenarioModityQuickPL(scenario: .constant(Scenario(from: sampleQuickie.quickPLs[0])))
            }
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
        
    }
}
