//
//  RevenueModal.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct RevenueModal: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @Binding var quickPL: QuickPL
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Covers".uppercased()),
                    footer: Text("VAT \(quickPL.vat.formattedPercentage). Average covers per day: \((Double(quickPL.noOfCoversPerWeek) / 7).rounded(.up).formattedGrouped).")) {
                        
                        Group {
                            RowWithStepperDouble(title: "Cover Price incl VAT",
                                                 currency: quickPL.currency,
                                                 amount: $quickPL.coverPriceVAT,
                                                 step: quickPL.currency == .rub ? 50 : 0.5)
                            
                            HStack {
                                Text("Cover Price ex VAT")
                                Spacer()
                                Text(quickPL.currency.idd + quickPL.coverPrice.threeSignificantDigits)
                                    .padding(.trailing, 102)
                            }
                            
                            RowWithStepperInt(title: "# of Covers per week",
                                              currency: .none,
                                              amount: $quickPL.noOfCoversPerWeek,
                                              step: 10)
                        }
                        .font(.subheadline)
                        //                            HStack {
                        //                                Text("Covers per day")
                        //                                Spacer()
                        //                                Text((Double(quickPL.noOfCoversPerWeek) / 7).rounded(.up).formattedGrouped)
                        //                            }
                        //                            .font(.subheadline)
                        //                            .foregroundColor(.secondary)
                }
                
                Section(header: Text("Revenue".uppercased()),
                        footer: VStack(alignment: .leading, spacing: 3) {
                            HStack(spacing:0) {
                                Text("revenue")
                                Spacer()
                                Text("per day")
                                    .frame(width: 50, alignment: .trailing)
                                Text("per week")
                                    .frame(width: 80, alignment: .trailing)
                                Text("per year")
                                    .frame(width: 120, alignment: .trailing)
                            }
                            .font(.caption2)
                            
                            HStack(spacing:0) {
                                Text("ex VAT")//Revenue per week
                                    .frame(width: 70, alignment: .leading)
                                Spacer()
                                Text(quickPL.currency.idd + quickPL.revenuePerDay.threeSignificantDigits)
                                    .frame(width: 70, alignment: .trailing)
                                Text(quickPL.currency.idd + quickPL.revenuePerWeek.threeSignificantDigits)
                                    .frame(width: 90, alignment: .trailing)
                                Text(quickPL.currency.idd + quickPL.revenuePerYear.threeSignificantDigits)
                                    .frame(width: 110, alignment: .trailing)
                            }
                            
                            HStack(spacing:0) {
                                Text("incl VAT")//Revenue per year
                                    .frame(width: 70, alignment: .leading)
                                Spacer()
                                Text(quickPL.currency.idd + quickPL.revenuePerDayVAT.threeSignificantDigits)
                                    .frame(width: 70, alignment: .trailing)
                                Text(quickPL.currency.idd + quickPL.revenuePerWeekVAT.threeSignificantDigits)
                                    .frame(width: 90, alignment: .trailing)
                                Text(quickPL.currency.idd + quickPL.revenuePerYearVAT.threeSignificantDigits)
                                    .frame(width: 110, alignment: .trailing)
                            }
                            // Text("\nEstimate Revenue by average Number of covers per week and average Cover Price.")
                }) {
                    Group {
                        
                        HStack {
                            Text("Revenue per month incl VAT")
                            Spacer()
                            Text(quickPL.currency.idd + (quickPL.revenuePerMonth * (1 + quickPL.vat)).threeSignificantDigits)
                        }
                        .foregroundColor(.secondary)
                        
                        HStack {
                            Text("Revenue per month ex VAT")
                            Spacer()
                            Text(quickPL.currency.idd + quickPL.revenuePerMonth.threeSignificantDigits)
                        }
                    }
                    .font(.subheadline)
                }
            }
            .navigationBarTitle("Revenue")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct RevenueModal_Previews: PreviewProvider {
    static var previews: some View {
        RevenueModal(quickPL: .constant(sampleQuickie.quickPLs[0]))
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
