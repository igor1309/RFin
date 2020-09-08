//
//  InvestmentEvaluationView.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI

struct InvestmentEvaluationView: View {
    var body: some View {
        NavigationView {
            TabView {
                List {
                    ReturnEstimateView()
                }
                .listStyle(InsetGroupedListStyle())
                
                List {
                    InvestmentToRevenueView()
                }
                
                List {
                    RevenueEstimateView()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct InvestmentEvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentEvaluationView()
    }
}
