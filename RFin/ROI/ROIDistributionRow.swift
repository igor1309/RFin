//
//  ROIDistributionRow.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ROIDistributionRow: View {
    var name: String
    
    var percentage1: Double
    var amount1: Double
    var percentage2: Double
    var amount2: Double
    
    var gap: CGFloat = 64 - 16
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            GeometryReader { geometry in
                if #available(iOS 14.0, *) {
                    HStack(spacing: 0) {
                        Group {
                            Text(self.name)
                                .frame(width: (geometry.size.width - self.gap) / 6, alignment: .leading)
                            Text("operating partner")
                                .frame(width: (geometry.size.width - self.gap) / 3, alignment: .trailing)
                        }
                        .foregroundColor(.systemIndigo)
                        Spacer()
                        Group {
                            Text("before")
                                .frame(width: (geometry.size.width - self.gap) / 6, alignment: .leading)
                            Text("investor")
                                .frame(width: (geometry.size.width - self.gap) / 3, alignment: .trailing)
                        }
                        .foregroundColor(.systemPurple)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Group {
                        Text(self.percentage1.formattedPercentage)
                            .frame(width: (geometry.size.width - self.gap) / 6, alignment: .leading)
                        Text(self.amount1.smartNotation)
                            .frame(width: (geometry.size.width - self.gap) / 3, alignment: .trailing)
                    }
                    .foregroundColor(.systemIndigo)
                    Spacer()
                    Group {
                        Text(self.percentage2.formattedPercentage)
                            .frame(width: (geometry.size.width - self.gap) / 6, alignment: .leading)
                        Text(self.amount2.smartNotation)
                            .frame(width: (geometry.size.width - self.gap) / 3, alignment: .trailing)
                    }
                    .foregroundColor(.systemPurple)
                }
                .font(.footnote)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ROIDistributionRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROIDistributionRow(name: "after", percentage1: 0.1, amount1: 888888888, percentage2: 1, amount2: 990_000)
                    .environment(\.sizeCategory, .extraExtraLarge)
                ROIDistributionRow(name: "after", percentage1: 0.1, amount1: 888888888, percentage2: 1, amount2: 990_000)
                    .environment(\.sizeCategory, .extraExtraExtraLarge)
                ROIDistributionRow(name: "after", percentage1: 0.1, amount1: 0, percentage2: 0.9, amount2: 9990_000)
                    .environment(\.sizeCategory, .accessibilityMedium)
                ROIDistributionRow(name: "before", percentage1: 0.1, amount1: 10_000, percentage2: 0.9, amount2: 990_000)
                    .environment(\.sizeCategory, .accessibilityLarge)
                ROIDistributionRow(name: "before", percentage1: 0.1, amount1: 10_000, percentage2: 0.9, amount2: 990_000)
                    .environment(\.sizeCategory, .accessibilityExtraLarge)
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
