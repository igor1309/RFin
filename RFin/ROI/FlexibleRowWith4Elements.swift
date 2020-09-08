//
//  FlexibleRowWith4Elements.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FlexibleRowWith4Elements: View {
    var text1: String
    var text2: String
    var text3: String
    var text4: String
    var isTesting = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if isTesting {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.systemTeal)
                            .frame(width: (geometry.size.width - 16) / 6, alignment: .leading)
                        Rectangle()
                            .foregroundColor(.systemYellow)
                            .frame(width: (geometry.size.width - 16) / 3, alignment: .trailing)
                        Spacer()
                        Rectangle()
                            .foregroundColor(.systemRed)
                            .frame(width: (geometry.size.width - 16) / 6, alignment: .leading)
                        Rectangle()
                            .foregroundColor(.systemBlue)
                            .frame(width: (geometry.size.width - 16) / 3, alignment: .trailing)
                    }
                }
            } else {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        Text(self.text1)
                            .frame(width: (geometry.size.width - 16) / 6, alignment: .leading)
                        Text(self.text2)
                            .frame(width: (geometry.size.width - 16) / 3, alignment: .trailing)
                        Spacer()
                        Text(self.text3)
                            .frame(width: (geometry.size.width - 16) / 6, alignment: .leading)
                        Text(self.text4)
                            .frame(width: (geometry.size.width - 16) / 3, alignment: .trailing)
                    }
                }
            }
        }
    }
}

struct FlexibleRowWith4Elements_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                FlexibleRowWith4Elements(text1: "0%", text2: "0", text3: "100%", text4: "100,000")
                FlexibleRowWith4Elements(text1: "0%", text2: "0", text3: "100%", text4: "100,000", isTesting: true)
                
                ROIDistributionRow(name: "before", percentage1: 0, amount1: 0, percentage2: 1, amount2: 100_000)
                ROIDistributionRow(name: "after", percentage1: 0.1, amount1: 10_000, percentage2: 0.9, amount2: 90_000)
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
