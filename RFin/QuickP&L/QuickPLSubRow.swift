//
//  QuickPLSubRow.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct QuickPLSubRow: View {
    @EnvironmentObject var settings: SettingsStore
    var quickPL: QuickPL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Text("investment")
                            .frame(width: 128, alignment: .leading)
                        Text("i / ce")
                            .foregroundColor(.systemYellow)
                        Spacer()
                        Text("cash earnings")
                            .foregroundColor(.systemYellow)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 14.0, *) {
                    HStack {
                        Text(quickPL.currency.idd + quickPL.investment.smartNotation)
                            .frame(width: 128, alignment: .leading)
                        Group {
                            Text(quickPL.investmentToNetCashFlow.formattedGrouped + "*")
                            if quickPL.investmentToNetCashFlow > 0 && quickPL.investmentToNetCashFlow <= Double(settings.investmentReturnPeriodThreshhold) {
                                Image(systemName: "star.circle")
                            }
                        }
                        .foregroundColor(.systemYellow)
                        Spacer()
                        Text("\(quickPL.currency.idd)\(quickPL.cashEarnings.smartNotation)")
                            .foregroundColor(.systemYellow)
                    }
                    .font(.title3)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Text("price incl VAT x covers per week").foregroundColor(.systemOrange)
                        Spacer()
                        Text("revenue ex VAT").foregroundColor(.systemGreen)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack {
                    Text("\(quickPL.currency.idd)\(quickPL.coverPriceVAT.smartNotation) x \(quickPL.noOfCoversPerWeek.formattedGrouped)")
                        .foregroundColor(.systemOrange)
                    Spacer()
                    Text("\(quickPL.currency.idd)\(quickPL.revenuePerMonth.smartNotation)")
                        .foregroundColor(.systemGreen)
                }
                .font(.subheadline)
            }
            
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Group {
                            Text("all costs")
                                .frame(width: 70, alignment: .leading)
                            Text("prime cost")
                                .frame(width: 70, alignment: .leading)
                            Text("")
                        }
                        .foregroundColor(.secondary)
                        Spacer()
                        Text("profit")
                            .foregroundColor(quickPL.profit > 0 ? .systemTeal : .systemRed)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack {
                    Group {
                        Text(quickPL.costsPercentage.formattedPercentage)
                            .frame(width: 70, alignment: .leading)
                        Text(quickPL.primeCostPercentage.formattedPercentage)
                            .frame(width: 70, alignment: .leading)
                        Text("")
                    }
                    .foregroundColor(.secondary)
                    Spacer()
                    Text("\(quickPL.currency.idd)\(quickPL.profit.smartNotation)")
                        .foregroundColor(quickPL.profit > 0 ? .systemTeal : .systemRed)
                }
                .font(.subheadline)
            }
            
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Group {
                            Text("foodcost")
                                .frame(width: 70, alignment: .leading)
                            Text("payroll")
                                .frame(width: 70, alignment: .leading)
                            Text("payroll")
                                .frame(width: 70, alignment: .leading)
                            Text("rent")
                        }
                        .foregroundColor(.secondary)
                        Spacer()
                        Text("")
                            .foregroundColor(quickPL.profit > 0 ? .systemTeal : .systemRed)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack {
                    Group {
                        Text(quickPL.foodcostPercentage.formattedPercentage)
                            .frame(width: 70, alignment: .leading)
                        Text(quickPL.payrollPercentage.formattedPercentage)
                            .frame(width: 70, alignment: .leading)
                        Text(quickPL.currency.idd + quickPL.payroll.smartNotation)
                            .frame(width: 70, alignment: .leading)
                        Text(quickPL.currency.idd + quickPL.rentRate.smartNotation)
                    }
                    .foregroundColor(.secondary)
                    Spacer()
                    Text("")
                }
                .font(.subheadline)
            }
        }
        .padding(.vertical, 3)
    }
}


struct QuickPLSubRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                QuickPLSubRow(quickPL: sampleQuickie.quickPLs[0])
                QuickPLSubRow(quickPL: sampleQuickie.quickPLs[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
