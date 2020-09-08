//
//  PayrollSuperMatrix.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayrollSuperMatrix: View {
    @EnvironmentObject var userData: UserData
    var staff: Staff
    
    var currencySymbol: String { userData.restaurant.currency.id }
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 16) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack(alignment: .top, spacing: 0) {
                            Text(" ")
                                .frame(width: 75, alignment: .leading)
                                .foregroundColor(.systemIndigo)
                            ForEach(self.staff.divisions, id: \.self) { division in
                                Text(division.id)
                                    .frame(width: 105, alignment: .trailing)
                            }
                            Text("Total")
                                .frame(width: 105, alignment: .trailing)
                                .foregroundColor(.primary)
                        }
                        
                        Divider()
                            .padding(.vertical, 3)
                        
                        ForEach(staff.products, id: \.self) { product in
                            
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                Text(product.id)
                                    .frame(width: 75, alignment: .leading)
                                
                                ForEach(self.staff.divisions, id: \.self) { division in
                                    VStack(alignment: .trailing, spacing: 3) {
                                        Text("\(self.formattedPayroll(product: product, division: division, type: .headcount)) × \(self.formattedPayroll(product: product, division: division, type: .hoursPerWeek))h").font(.caption)
                                        Text(self.formattedPayroll(product: product, division: division, type: .avgPayPerHourBrutto))
                                        Text(self.formattedPayroll(product: product, division: division, type: .monthlyBruttoBrutto))
                                        
                                        Divider()
                                            .padding(.vertical, 3)
                                    }
                                    .font(.caption)
                                    .frame(width: 105, alignment: .trailing)
                                }
                                
                                VStack(alignment: .trailing, spacing: 3) {
                                    Text("\(self.formattedPayroll(product: product, type: .headcount)) × \(self.formattedPayroll(product: product, type: .hoursPerWeek))h").font(.caption)
                                    Text(self.formattedPayroll(product: product, type: .avgPayPerHourBrutto))
                                    Text(self.formattedPayroll(product: product, type: .monthlyBruttoBrutto))
                                    
                                    Divider()
                                        .padding(.vertical, 3)
                                }
                                .frame(width: 105, alignment: .trailing)
                                .font(.caption)
                                .foregroundColor(.primary)
                            }
                        }
                        
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text("Total")
                                .frame(width: 75, alignment: .leading)
                            
                            ForEach(self.staff.divisions, id: \.self) { division in
                                
                                VStack(alignment: .trailing, spacing: 3) {
                                    Text("\(self.formattedPayroll(division: division, type: .headcount)) × \(self.formattedPayroll(division: division, type: .hoursPerWeek))h").font(.caption)
                                    Text(self.formattedPayroll(division: division, type: .avgPayPerHourBrutto))
                                    Text(self.formattedPayroll(division: division, type: .monthlyBruttoBrutto))
                                }
                                .frame(width: 105, alignment: .trailing)
                            }
                            
                            VStack(alignment: .trailing, spacing: 3) {
                                Text("\(self.formattedPayroll(type: .headcount)) × \(self.formattedPayroll(type: .hoursPerWeek))h").font(.caption)
                                Text(self.formattedPayroll(type: .avgPayPerHourBrutto))
                                Text(self.formattedPayroll(type: .monthlyBruttoBrutto))
                            }
                            .frame(width: 105, alignment: .trailing)
                        }
                        .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationBarTitle(Text("Product Division Matrix"), displayMode: .inline)
        }
    }
    
    func formattedPayroll(product: Product? = nil, division: Division? = nil, type: PayrollType) -> String {
        
        let payroll = staff.payroll(product: product, division: division, type: type)
        
        if payroll == 0 { return "-" }
        
        switch type {
        case .headcount:
            return payroll.formattedGrouped
        case .weeklyBrutto, .weeklyBruttoBrutto, .monthlyBrutto, .monthlyBruttoBrutto:
            return currencySymbol + payroll.formattedGrouped
        case .hoursPerWeek:
            return payroll.formattedGroupedWith1Decimal
        case .avgPayPerHourBrutto, .avgPayPerHourBruttoBrutto:
            return currencySymbol + payroll.formattedGroupedWithDecimals
        }
    }
}

struct PayrollSuperMatrix_Previews: PreviewProvider {
    static var previews: some View {
        PayrollSuperMatrix(staff: Staff(name: "Sample", positions: samplePositions))
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
