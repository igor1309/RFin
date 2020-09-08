//
//  PageTwo.swift
//  Investment Evaluation
//
//  Created by Igor Malyarov on 20.07.2020.
//

import SwiftUI

struct InvestmentToRevenueView: View {
    private let periods: [Double] = [1, 1.5, 2, 2.5, 3, 3.5]
    
    @State private var returnPeriod: Double = 3
    @State private var netProfitMargin: Double = 15/100
    
    private var investmentToMonthlyRevenueRatio: Double {
        returnPeriod * netProfitMargin * 12
    }
    
    var body: some View {
        Group {
            TitleView("Investment to Monthly Revenue: \(investmentToMonthlyRevenueRatio.formattedGroupedWith1Decimal)")
            
            Section(header: Text("Years to return Investment")) {
                Picker("Return Period", selection: $returnPeriod) {
                    ForEach(periods, id: \.self) { period in
                        Text("\(period, specifier: "%.1f")").tag(period)
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

struct PageTwo_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentToRevenueView()
            .preferredColorScheme(.dark)
    }
}
