//
//  GlobalSettings.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct GlobalSettings: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        Group {
            Text("cards to save")
                .font(.subheadline)
                .foregroundColor(.systemTeal)
            
            Section(
                header: Text("IRR Threshhold"),
                footer: Text("IRR Threshhold value to mark")
            ) {
                RowWithStepperPercentage(title: "IRR Threshhold", amount: $settings.irrThreshhold, step: 0.0025)
                    .onAppear {
                        if settings.irrThreshhold == 0 {
                            settings.irrThreshhold = 0.12
                        }}
            }
            
            Section(
                header: Text("Investment Return Period Threshhold"),
                footer: Text("Return Period mark")
            ) {
                RowWithStepperInt(title: "Period, months", currency: .none, amount: $settings.investmentReturnPeriodThreshhold, step: 1)
                    .onAppear{
                        if settings.investmentReturnPeriodThreshhold == 0 {
                            settings.investmentReturnPeriodThreshhold = 24
                        }}
            }
            
            Section(
                header: Text("Distribution"),
                footer: Text("see yearly distribution").padding(.bottom)
            ) {
                Toggle("Show distribution per year", isOn: $settings.showPerYear)
            }
        }
    }
}

struct GlobalSettings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                GlobalSettings()
            }
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
