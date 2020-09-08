//
//  ROIDetailInvestorSections.swift
//  RFin
//
//  Created by Igor Malyarov on 13.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ROIDetailInvestorSections: View {
    @EnvironmentObject var settings: SettingsStore
    @Binding var otbivka: Otbivka
    
    var body: some View {
        Group {
            Section(
                header: Text("Investment")
            ) {
                Group {
                    HStack {
                        Text("Investment total")
                        Spacer()
                        Text(otbivka.investment.formattedGrouped)
                            .foregroundColor(.systemOrange)
                    }
                    Stepper(value: $otbivka.investment, in: 100_000...50_000_000, step: 50_000) {
                        Slider(value: $otbivka.investment, in: 100_000...50_000_000, step: 50_000)
                    }
                }
                .font(.subheadline)
            }
            
            Section(
                header: Text("Investment Return"),
                footer: Text("Grace Period — это период выхода проекта на целевую мощность (целых или дробных лет), в течение которого выплаты инвестору не производятся. Шаг изменения — квартал.")
            ) {
                Group {
                    Stepper(value: $otbivka.monthsToReturnInvestment, in: 18...48, step: 3) {
                        HStack {
                            if #available(iOS 14.0, *) {
                                Label("Years to Return", systemImage: "calendar")
                            } else {
                                // Fallback on earlier versions
                                Image(systemName: "calendar")
                                    .frame(minWidth: 22, alignment: .trailing)
                                Text("Years to Return")
                            }
                            Spacer()
                            Text(otbivka.yearsToReturnInvestment.formattedGroupedWithMax2Decimals)
                                .foregroundColor(.systemOrange)
                        }
                    }
                    
                    
                    Stepper(value: $otbivka.graceNumberOfMonths, in: 0...(otbivka.monthsToReturnInvestment - 1), step: 3) {
                        HStack {
                            if #available(iOS 14.0, *) {
                                Label("Grace Period, years", systemImage: "calendar.badge.minus")
                            } else {
                                Image(systemName: "calendar.badge.minus")
                                    .frame(minWidth: 22, alignment: .trailing)
                                Text("Grace Period, years")
                            }
                            Spacer()
                            Text(otbivka.gracePeriodInYears.formattedGroupedWithMax2Decimals)
                                .foregroundColor(.systemOrange)
                        }
                    }
                }
                .font(.subheadline)
            }
            
            Section(header: Text("Investor's Share".uppercased()),
                    footer: Text("Profit sharing between Investor and Operating Partner before investment is paid back (\"returned\") and after.")
            ) {
                Group {
                    Stepper(value: $otbivka.investorsShareBeforeReturn, in: 0...1, step: 0.05) {
                        HStack {
                            if #available(iOS 14.0, *) {
                                Label("Before Return", systemImage: "square.fill.and.line.vertical.and.square")
                            } else {
                                Image(systemName: "square.fill.and.line.vertical.and.square")
                                    .frame(minWidth: 28, alignment: .leading)
                                Text("Before Return")
                            }
                            Spacer()
                            Text(otbivka.investorsShareBeforeReturn.formattedPercentage)
                                .foregroundColor(.systemOrange)
                        }
                    }
                    
                    Stepper(value: $otbivka.investorsShareAfterReturn, in: 0...1, step: 0.05) {
                        HStack {
                            if #available(iOS 14.0, *) {
                                Label("After Return", systemImage: "square.and.line.vertical.and.square.fill")
                            } else {
                                Image(systemName: "square.and.line.vertical.and.square.fill")
                                    .frame(minWidth: 28, alignment: .leading)
                                Text("After Return")
                            }
                            Spacer()
                            Text(otbivka.investorsShareAfterReturn.formattedPercentage)
                                .foregroundColor(.systemOrange)
                        }
                    }
                }
                .font(.subheadline)
            }
        }
    }
}

struct ROIDetailInvestorSections_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ROIDetailInvestorSections(otbivka: .constant(sampleROICollection.otbivki[1]))
            }
        }
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
