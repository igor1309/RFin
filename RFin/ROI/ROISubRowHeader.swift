//
//  ROISubRowHeader.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ROISubRowHeader: View {
    @EnvironmentObject var settings: SettingsStore
    var otbivka: Otbivka
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if #available(iOS 14.0, *) {
                Text(otbivka.name)
                    .font(.title2).fontWeight(.semibold)
                    .frame(width: 228, alignment: .leading)
            } else {
                // Fallback on earlier versions
            }
            if otbivka.irr ?? 0 >= settings.irrThreshhold {
                Image(systemName: "star.circle")
                    .foregroundColor(.systemYellow)
                    .padding(.bottom, 2)
                Spacer()
            }
            if #available(iOS 14.0, *) {
                Text("\(otbivka.investment.smartNotation)")
                    .font(.title2)
            } else {
                // Fallback on earlier versions
            }
        }
        .foregroundColor(.systemOrange)
        .padding(.bottom, 6)
    }
}

struct ROISubRowHeaderNEW: View {
    @EnvironmentObject var settings: SettingsStore
    var otbivka: Otbivka
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if #available(iOS 14.0, *) {
                Text(otbivka.name)
                    .font(.title2).fontWeight(.semibold)
            } else {
                // Fallback on earlier versions
            }
//                .frame(width: 228, alignment: .leading)
            if otbivka.irr ?? 0 >= settings.irrThreshhold {
                Spacer()
                Image(systemName: "star.circle")
                    .foregroundColor(.systemYellow)
                    .padding(.bottom, 2)
            }
//            Text("\(otbivka.investment.smartNotation)")
//                .font(.title2)
        }
        .foregroundColor(.systemOrange)
        .padding(.bottom, 6)
    }
}

struct ROISubRowHeader2: View {
    var otbivka: Otbivka
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                if #available(iOS 14.0, *) {
                    Text("investment")
                        .font(.caption2)
                        .foregroundColor(.systemOrange)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(otbivka.name)
                Spacer()
                Text("\(otbivka.investment.formattedGrouped)")
            }
            .font(.headline)
            .foregroundColor(.systemOrange)
        }
    }
}

struct ROISubRowHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROISubRowHeaderNEW(otbivka: sampleROICollection.otbivki[0])
                ROISubRowHeaderNEW(otbivka: sampleROICollection.otbivki[1])
                ROISubRowHeaderNEW(otbivka: sampleROICollection.otbivki[2])

                Spacer()
                
                ROISubRowHeader(otbivka: sampleROICollection.otbivki[0])
                ROISubRowHeader(otbivka: sampleROICollection.otbivki[1])
                ROISubRowHeader(otbivka: sampleROICollection.otbivki[2])

                Spacer()
                
                ROISubRowHeader2(otbivka: sampleROICollection.otbivki[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

