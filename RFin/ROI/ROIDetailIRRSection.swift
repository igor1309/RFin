//
//  ROIDetailIRRSection.swift
//  RFin
//
//  Created by Igor Malyarov on 13.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ROIDetailIRRSection: View {
    @EnvironmentObject var settings: SettingsStore
    @Binding var otbivka: Otbivka
    
    var body: some View {
        Section(
            header: Text("Investor's ROI".uppercased()),
            footer: Text("Период для оценки дохода инвестора должен быть больше срока возврата инвестиций. IRR считается на основе квартальных потоков.")
                .foregroundColor(otbivka.estimationPeriodInYears > otbivka.yearsToReturnInvestment ? .secondary : .systemRed)
        ) {
            Group {
                HStack {
                    if #available(iOS 14.0, *) {
                        Label("IRR", systemImage: otbivka.irr ?? 0 >= settings.irrThreshhold ? "star.circle" : "percent")
                    } else {
                        Image(systemName: otbivka.irr ?? 0 >= settings.irrThreshhold ? "star.circle" : "percent")
                            .frame(minWidth: 22, alignment: .leading)
                        Text("IRR")
                    }
                    Spacer()
                    Text(otbivka.irr?.formattedPercentageWith1Decimal ?? "n/a")
                }
                .foregroundColor(otbivka.irr ?? 0 >= settings.irrThreshhold ? .systemYellow : .primary)
                
                HStack {
                    if #available(iOS 14.0, *) {
                        Label("Distribution, total", systemImage: "briefcase")
                    } else {
                        Image(systemName: "briefcase")
                            .frame(minWidth: 22, alignment: .leading)
                        Text("Distribution, total")
                    }
                    Spacer()
                    Text(otbivka.investorsDistribution.formattedGrouped)
                }
                .foregroundColor(.secondary)
                
                HStack {
                    if #available(iOS 14.0, *) {
                        Label("Profit", systemImage: "briefcase.fill")
                    } else {
                        Image(systemName: "briefcase.fill")
                            .frame(minWidth: 22, alignment: .leading)
                        Text("Profit")
                    }
                    Spacer()
                    Text(otbivka.investorsProfit.formattedGrouped)
                }
                .foregroundColor(.systemGreen)
                
                Stepper(value: $otbivka.estPeriodInMonths, in: (otbivka.monthsToReturnInvestment + 1)...96, step: 3) {
                    if #available(iOS 14.0, *) {
                        Label {
                            Row(title: "Estimation Period", detail: otbivka.estimationPeriodInYears.formattedGroupedWithMax2Decimals + "y")
                        } icon: {
                            Image(systemName: "calendar")
                        }
                    } else {
                        HStack {
                            Image(systemName: "calendar")
                                .frame(minWidth: 22, alignment: .leading)
                            Row(title: "Estimation Period", detail: otbivka.estimationPeriodInYears.formattedGroupedWithMax2Decimals + "y")
                        }
                    }
                }
            }
            .font(.subheadline)
        }
    }
}

struct ROIDetailIRRSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ROIDetailIRRSection(otbivka: .constant(sampleROICollection.otbivki[1]))
            }
        }
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
