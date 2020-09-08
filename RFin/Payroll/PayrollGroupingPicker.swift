//
//  PayrollGroupingPicker.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayrollGroupingPicker: View {
    @EnvironmentObject var settings: SettingsStore
    var body: some View {
        Picker("Select Grouping", selection: $settings.selectedPayrollGrouping) {
            ForEach(PayrollGrouping.allCases, id: \.self) {
                Text($0.id).tag($0)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct PayrollGroupingPicker_Previews: PreviewProvider {
    static var previews: some View {
        PayrollGroupingPicker()
            .environmentObject(SettingsStore())
    }
}
