//
//  PayDetail.swift
//  Payroll
//
//  Created by Igor Malyarov on 13.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayDetail: View {
    @EnvironmentObject var userData: UserData
    
    var hoursTitle: String
    @Binding var hours: Double
    
    var rateTitle: String
    @Binding var rate: Double
    
    var bonusTitle: String
    @Binding var bonusRate: Double
    
    var employerContributionsTitle: String = "Employer's contributions"
    @Binding var employerContributions: Double
    
    var isBasePay = true    //  false if bonus pay
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        VStack {
            Stepper(value: $hours, in: 0...60, step: 0.5) {
                HStack {
                    Text(hoursTitle)
                    Spacer()
                    Text(hours.formattedGroupedWithDecimals)
                        .foregroundColor(.systemOrange)
                }
            }
            
            if isBasePay {
                Stepper(value: $rate, in: 6...600, step: 0.25) {
                    HStack {
                        Text(rateTitle)
                        Spacer()
                        Text(currency.idd + rate.formattedGroupedWithDecimals)
                            .foregroundColor(.systemOrange)
                    }
                }
            } else {
                Stepper(value: $bonusRate, in: 0...2, step: 0.05) {
                    HStack {
                        Text(bonusTitle)
                        Spacer()
                        Text(bonusRate.formattedPercentage)
                            .foregroundColor(.systemOrange)
                    }
                }
            }
            
            Stepper(value: $employerContributions, in: 0...0.5, step: 0.025) {
                HStack {
                    Text(employerContributionsTitle)
                    Spacer()
                    Text(employerContributions.formattedPercentageWithDecimals)
                }.foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}
struct PayDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                PayDetail(hoursTitle: "normal", hours: .constant(8), rateTitle: "norm rate", rate: .constant(13), bonusTitle: "bonus", bonusRate: .constant(0.2), employerContributionsTitle: "contribution", employerContributions: .constant(0.2), isBasePay: true)
                PayDetail(hoursTitle: "normal", hours: .constant(8), rateTitle: "norm rate", rate: .constant(13), bonusTitle: "bonus", bonusRate: .constant(0.2), employerContributionsTitle: "contribution", employerContributions: .constant(0.2), isBasePay: false)
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
