//
//  ROISubRowDistributionPerMonth.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI


struct ROIDistributionRowsGroup: View {
    var otbivka: Otbivka
    
    var body: some View {
        Group {
            ROIDistributionRow(name: "before",
                               percentage1: self.otbivka.opShareBeforeReturn,
                               amount1:     self.otbivka.opDistributionPerMonthBeforeReturn,
                               percentage2: self.otbivka.investorsShareBeforeReturn,
                               amount2:     self.otbivka.investorsDistributionPerMonthBeforeReturn)
            
            ROIDistributionRow(name: "after",
                               percentage1: self.otbivka.opShareAfterReturn,
                               amount1:     self.otbivka.opDistributionPerMonthAfterReturn,
                               percentage2: self.otbivka.investorsShareAfterReturn,
                               amount2:     self.otbivka.investorsDistributionPerMonthAfterReturn)
        }
        .embedInStack()
    }
}

struct ROISubRowDistributionPerMonth: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var otbivka: Otbivka
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 0) {
                Text("total distribution per month")
                    .foregroundColor(.systemTeal)
                    .font(.caption2)
                Text(otbivka.distributionPerMonth.smartNotation)
                    .font(.footnote)
                    .font(.caption2)
                    .foregroundColor(.systemTeal)
            }
            
            ROIDistributionRowsGroup(otbivka: otbivka)
        }
        .padding(.vertical, 3)
    }
}

struct ROISubRowDistributionPerMonth_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROISubRowDistributionPerMonth(otbivka: sampleROICollection.otbivki[0])
                Text("Compare to:").font(.subheadline).padding(.top)
                ROISubRowDistributionPerYear(otbivka: sampleROICollection.otbivki[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
