//
//  MainListView.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI

struct MainListView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    ListRowWithSheet(icon: "hare", title: "Quick P&L", subtitle: "Model Restaurant P&L with Scenarios.", color: .systemYellow) {
                        NavigationView {
                            QuickPLList()
                        }
                    }
                    ListRowWithSheet(icon: "chart.bar", title: "ROI", subtitle: "Estimate Return on Investment.", color: .systemPurple) {
                        NavigationView {
                            ROIList()
                        }
                    }
                    ListRowWithSheet(icon: "person.2", title: "Payroll", subtitle: "Create and analyse Staff versions.", color: .systemTeal) {
                        NavigationView {
                            StaffVersionsView()
                        }
                    }
                    ListRowWithSheet(icon: "rectangle.grid.2x2", title: "Rent", subtitle: "Rent with options.", color: .systemOrange) {
                        NavigationView {
                            SpaceList()
                        }
                    }
                }
                
                Section {
                    ListRowWithSheet(icon: "square.stack.3d.down.right.fill", title: "Margin and Markup", subtitle: "", color: .systemYellow) {
                        MarginMarkup()
                    }
                }
                
                Section {
                    ListRowWithSheet(icon: "clock.arrow.circlepath", title: "Return Estimate", subtitle: "Investment Return Estimate using ratio to Monthly Revenue and Net Profit Margin.", color: .systemPurple) {
                        VStack {
                            ReturnEstimateView()
                                .padding()
                            Spacer()
                        }
                    }
                    ListRowWithSheet(icon: "briefcase", title: "Investment to Revenue", subtitle: "Investment to Monthly Revenue.", color: .systemPurple) {
                        VStack {
                            InvestmentToRevenueView()
                                .padding()
                            Spacer()
                        }
                    }
                    ListRowWithSheet(icon: "creditcard", title: "Revenue Estimate", subtitle: "Estimate using Restaurant Capacity, Turnover and Everage Cover.", color: .systemGreen) {
                        VStack {
                            RevenueEstimateView()
                                .padding()
                            Spacer()
                        }
                    }
                    ListRowWithSheet(icon: "dollarsign.circle", title: "Investment Evaluation (3 in 1)", subtitle: "", color: .secondary) {
                        InvestmentEvaluationView()
                    }
                }
                
                //                Section {
                //                    ListRowWithSheet(icon: "book", title: "Wiki", subtitle: "Reference Guide.", color: .primary) {
                //                        NavigationView {
                //                            WikiView()
                //                        }
                //                    }
                //                }
                
                WikiSections()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Main List")
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .preferredColorScheme(.dark)
    }
}
