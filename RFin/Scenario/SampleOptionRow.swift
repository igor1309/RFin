//
//  SampleOptionRow.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SampleOptionRow: View {
    var otbivka: Otbivka
    var gap: CGFloat = 64 - 16
    
    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
            GeometryReader { geometry in
                HStack(spacing: 8) {
                    HStack {
                        Text("Before")
                            .frame(width: (geometry.size.width - self.gap) / 4, alignment: .leading)
                        //                        .border(Color.systemPink)
                        Text(self.otbivka.investorsShareBeforeReturn.formattedPercentage)
                            .frame(width: (geometry.size.width - self.gap) / 6, alignment: .trailing)
                        //                        .border(Color.systemPink)
                    }
                    .foregroundColor(.systemPurple)
                    
                    Spacer()
                    
                    HStack {
                        Text("After")
                            .frame(width: (geometry.size.width - self.gap) / 4, alignment: .leading)
                        //                        .border(Color.systemPink)
                        Text(self.otbivka.investorsShareAfterReturn.formattedPercentage)
                            .frame(width: (geometry.size.width - self.gap) / 6, alignment: .trailing)
                        //                        .border(Color.systemPink)
                    }
                    .foregroundColor(.systemBlue)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
//        }
        .font(.subheadline)
        .padding(.bottom, 1)
    }
}

struct SampleOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                SampleOptionRow(otbivka: sampleOptions[0].otbivka)
                SampleOptionRow(otbivka: sampleOptions[1].otbivka)
                SampleOptionRow(otbivka: sampleOptions[2].otbivka)
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
