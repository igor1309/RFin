//
//  PresentValueDetailView.swift
//  PresentValue
//
//  Created by Igor Malyarov on 15.02.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PresentValueDetailView: View {
    @EnvironmentObject var presentValueData: PresentValueData

    let payments: [Double] = [1, 3, 5, 10, 20, 50, 100]
    let lifetimes: [Int] = [1, 2, 5, 10, 20, 40]
    let rates: [Double] = [3/100, 6/100, 9/100, 12/100, 18/100]
    let multipliers = [10, 100, 1_000, 1_000_000, 1_000_000_000]
    
    var body: some View {
        Form {
            Section(header: Text("Present Value"),
                    footer: Text(presentValueData.rccf.explanation() + " ").foregroundColor(.primary)
                        + Text(presentValueData.rccf.explanation(presentValueData.multiplier))) {
                            HStack {
                                Text("Payment PV")
                                Spacer()
                                Text(presentValueData.rccf.pv.formattedGrouped)
                            }
                            .font(.headline)
                            .foregroundColor(.systemYellow)
            }
            
            Section(header: Text("Payment Amount")) {
                Picker(selection: $presentValueData.rccf.payment, label: Text("Payment Amount")) {
                    ForEach(payments, id: \.self) { payment in
                        Text("\(Int(payment))").tag(payment)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Payment Period")) {
                Picker(selection: $presentValueData.rccf.period, label: Text("Payment Period")) {
                    ForEach(RegularConstantCashFlow.Period.allCases, id: \.self) { period in
                        Text(period.id).tag(period)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Lifetime")) {
                Picker(selection: $presentValueData.rccf.lifetimeType, label: Text("Lifetime Type")) {
                    ForEach(RegularConstantCashFlow.LifetimeType.allCases, id: \.self) { lifetimeType in
                        Text(lifetimeType.id).tag(lifetimeType)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                
                if presentValueData.rccf.lifetimeType != .perpetual {
                    Picker(selection: $presentValueData.rccf.lifetime, label: Text("Lifetime in Years")) {
                        ForEach(lifetimes, id: \.self) { lifetime in
                            Text("\(lifetime.formattedGrouped)").tag(lifetime)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Section(header: Text("Annual Discount Rate")) {
                Picker(selection: $presentValueData.rccf.annualRate, label: Text("Annual Discount Rate")) {
                    ForEach(rates, id: \.self) { rate in
                        Text(rate.formattedPercentage).tag(rate)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Multiplier")) {
                Picker(selection: $presentValueData.multiplier, label: Text("Multiplier")) {
                    ForEach(multipliers, id: \.self) { multiplier in
                        Text(multiplier.threeSignificantDigits).tag(multiplier)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationBarTitle(Text("Present Value"), displayMode: .inline)
    }
}

struct PresentValueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PresentValueDetailView()
            .preferredColorScheme(.dark)
            .environmentObject(PresentValueData())
    }
}
