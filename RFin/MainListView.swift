//
//  MainListView.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI

struct MainListView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ListRowWithSheet(sizeClass: sizeClass, icon: "hare", title: "Quick P&L", subtitle: "Model Restaurant P&L with Scenarios.", color: .systemYellow) {
                        QuickPLList()
                    }
                    ListRowWithSheet(sizeClass: sizeClass, icon: "chart.bar", title: "ROI", subtitle: "Estimate Return on Investment.", color: .systemPurple) {
                        ROIList()
                    }
                    ListRowWithSheet(sizeClass: sizeClass, icon: "person.2", title: "Payroll", subtitle: "Create and analyse Staff versions.", color: .systemTeal) {
                        StaffVersionsView()
                    }
                    ListRowWithSheet(sizeClass: sizeClass, icon: "rectangle.grid.2x2", title: "Rent", subtitle: "Rent with options.", color: .systemOrange) {
                        SpaceList()
                    }
                }
                
                Section {
                    ListRowWithSheet(sizeClass: sizeClass, icon: "square.stack.3d.up.fill", title: "Margin and Markup", subtitle: "", color: .systemYellow) {
                        MarginMarkup()
                    }
                }
                
                Section {
                    ListRowWithSheet(sizeClass: sizeClass, icon: "pesetasign.circle", title: "Present Value", subtitle: "Present Value of Discounted Constant Payments.", color: .systemGreen) {
                        PresentValueView()
                            .padding(.horizontal)
                            .environmentObject(PresentValueData())
                    }
                }
                
                Section {
                    ListRowWithSheet(sizeClass: sizeClass, icon: "clock.arrow.circlepath", title: "Return Estimate", subtitle: "Investment Return Estimate using ratio to Monthly Revenue and Net Profit Margin.", color: .systemPurple) {
                        VStack {
                            ReturnEstimateView()
                                .padding()
                            Spacer()
                        }
                    }
                    ListRowWithSheet(sizeClass: sizeClass, icon: "briefcase", title: "Investment to Revenue", subtitle: "Investment to Monthly Revenue.", color: .systemPurple) {
                        VStack {
                            InvestmentToRevenueView()
                                .padding()
                            Spacer()
                        }
                    }
                    ListRowWithSheet(sizeClass: sizeClass, icon: "creditcard", title: "Revenue Estimate", subtitle: "Estimate using Restaurant Capacity, Turnover and Everage Cover.", color: .systemGreen) {
                        VStack {
                            RevenueEstimateView()
                                .padding()
                            Spacer()
                        }
                    }
                    ListRowWithSheet(sizeClass: sizeClass, icon: "dollarsign.circle", title: "Investment Evaluation (3 in 1)", subtitle: "", color: .secondary) {
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
                
                WikiSections(sizeClass: sizeClass ?? .compact)
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
