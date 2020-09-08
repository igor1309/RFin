//
//  ROISubRowMainPart.swift
//  RFin
//
//  Created by Igor Malyarov on 14.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ROISubRowMainPart: View {
    @EnvironmentObject var settings: SettingsStore
    var otbivka: Otbivka
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack(spacing: 0) {
                        Text("IRR")
                            .frame(minWidth: 112, alignment: .leading)
                            .foregroundColor(.systemYellow)
                        Text("est. period")
                            .frame(minWidth: 64, alignment: .leading)
                        Spacer()
                        Text("investor's profit")
                            .foregroundColor(.systemGreen)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack(spacing: 0) {
                    HStack {
                        Text(otbivka.irr?.formattedPercentageWith1Decimal ?? "n/a")
                        if otbivka.irr ?? 0 >= settings.irrThreshhold {
                            Image(systemName: "star.circle")
                                .foregroundColor(.systemYellow)
                                .padding(.bottom, 3)
                        }
                    }
                    .frame(minWidth: 112, alignment: .leading)
                    .foregroundColor(.systemYellow)
                    
                    Text(otbivka.estimationPeriodInYears.formattedGroupedWithMax2Decimals + "y")
                        .frame(minWidth: 64, alignment: .leading)
                    Spacer()
                    Text(otbivka.investorsProfit.smartNotation)
                        .foregroundColor(.systemGreen)
                }
            }
            
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack(spacing: 0) {
                        Text("return in")
                            .frame(minWidth: 56, alignment: .leading)
                            .foregroundColor(.systemOrange)
                        Text("grace")
                            .frame(minWidth: 56, alignment: .leading)
                        Text("before")
                            .frame(minWidth: 56, alignment: .leading)
                            .foregroundColor(.systemBlue)
                        Text("after")
                            .frame(minWidth: 56, alignment: .leading)
                            .foregroundColor(.systemBlue)
                        Spacer()
                        Text("distribution to investor")
                    }
                    .font(.caption2)
                    .foregroundColor(.secondary)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack(spacing: 0) {
                    Text("\(otbivka.yearsToReturnInvestment.formattedGroupedWithMax2Decimals)y")
                        .frame(minWidth: 56, alignment: .leading)
                        .foregroundColor(.systemOrange)
                    Text("\(otbivka.gracePeriodInYears.formattedGroupedWithMax2Decimals)y")
                        .frame(minWidth: 56, alignment: .leading)
                    Text(otbivka.investorsShareBeforeReturn.formattedPercentage)
                        .frame(minWidth: 56, alignment: .leading)
                        .foregroundColor(.systemBlue)
                    Text(otbivka.investorsShareAfterReturn.formattedPercentage)
                        .frame(minWidth: 56, alignment: .leading)
                        .foregroundColor(.systemBlue)
                    Spacer()
                    Text(otbivka.investorsDistribution.smartNotation)
                        .font(.subheadline)
                    
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 3)
    }
}

struct ROISubRowMainPart_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROISubRowMainPart(otbivka: sampleROICollection.otbivki[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
