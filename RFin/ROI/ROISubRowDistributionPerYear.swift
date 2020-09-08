//
//  ROISubRowDistributionPerYear.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ROISubRowDistributionPerYear: View {
    var otbivka: Otbivka
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 0) {
                if #available(iOS 14.0, *) {
                    Text("total distribution per year")
                        .foregroundColor(.systemTeal)
                        .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                if #available(iOS 14.0, *) {
                    Text(otbivka.distributionPerYear.smartNotation)
                        .font(.footnote)
                        .font(.caption2)
                        .foregroundColor(.systemTeal)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            ROIDistributionRow(name: "before",
                               percentage1: otbivka.opShareBeforeReturn,
                               amount1:     otbivka.opDistributionPerYearBeforeReturn,
                               percentage2: otbivka.investorsShareBeforeReturn,
                               amount2:     otbivka.investorsDistributionPerYearBeforeReturn)
            
            ROIDistributionRow(name: "after",
                               percentage1: otbivka.opShareAfterReturn,
                               amount1:     otbivka.opDistributionPerYearAfterReturn,
                               percentage2: otbivka.investorsShareAfterReturn,
                               amount2:     otbivka.investorsDistributionPerYearAfterReturn)
        }
        .padding(.vertical, 3)
    }
}


struct ROISubRowDistributionPerYear_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROISubRowDistributionPerYear(otbivka: sampleROICollection.otbivki[0])
                Text("Compare to:").font(.subheadline).padding(.top)
                ROISubRowDistributionPerMonth(otbivka: sampleROICollection.otbivki[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
