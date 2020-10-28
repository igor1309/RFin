//
//  BenchmarkSettings.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BenchmarkSettings: View {
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit")) {
                    Toggle("Allow editing", isOn: $settings.editingIsAllowed)
                    
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(
                trailing: TrailingButtonSFSymbol("checkmark") {
                    self.presentation.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct BenchmarkSettings_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkSettings()
            .environment(\.colorScheme, .dark)
            .environmentObject(SettingsStore())
    }
}
