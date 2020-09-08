//
//  ContentView.swift
//  Investment Evaluation
//
//  Created by Igor Malyarov on 20.07.2020.
//

import SwiftUI

struct ReturnEstimateView: View {
    private let ratios: [Double] = [1, 2, 3, 4, 5, 6, 9, 12]
    
    @State private var investmentToMonthlyRevenueRatio: Double = 6
    @State private var netProfitMargin: Double = 15/100
    
    private var returnPeriodMonths: Double {
        investmentToMonthlyRevenueRatio / netProfitMargin
    }
    
    var returnPeriodYears: Double {
        returnPeriodMonths / 12
    }
    
    var body: some View {        
        Group {
            Text("Investment Return in \(returnPeriodMonths, specifier: "%.f")m (\(returnPeriodYears, specifier: "%.1f")y)")
                .foregroundColor(.orange)
                .font(.title)
                .padding(.top)
            
            Section(header: Text("Investment to Monthly Revenue")) {
                Picker("Investment to Monthly Revenue", selection: $investmentToMonthlyRevenueRatio) {
                    ForEach(ratios, id: \.self) { ratio in
                        Text("\(ratio, specifier: "%.f"):1").tag(ratio)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Net Profit Margin")) {
                NetProfitMarginPicker(netProfitMargin: $netProfitMargin)
            }
        }
    }
}

struct PageOne_Previews: PreviewProvider {
    static var previews: some View {
        ReturnEstimateView()
            .preferredColorScheme(.dark)
    }
}
