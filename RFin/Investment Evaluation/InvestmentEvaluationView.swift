//
//  InvestmentEvaluationView.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI

struct InvestmentEvaluationView: View {
    var body: some View {
        TabView {
            List {
                ReturnEstimateView()
            }
            
            List {
                InvestmentToRevenueView()
            }
            
            List {
                RevenueEstimateView()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InvestmentEvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentEvaluationView()
    }
}
