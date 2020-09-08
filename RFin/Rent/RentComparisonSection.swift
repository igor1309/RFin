//
//  RentComparison.swift
//  Rent
//
//  Created by Igor Malyarov on 27.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RentComparisonSection: View {
    @EnvironmentObject var userData: UserData
    @Binding var space: Space

    var body: some View {
        Section(
            header: Text("Fixed vs Combo Rent Rate Comparison")
        ) {
            VStack(spacing: 8) {
                HStack {
                    Text("Fixed Rent")
                    Spacer()
                    Text(userData.restaurant.currency.idd + space.fixedRent.formattedGrouped)
                }
                
                HStack {
                    Text("Fixed Rent to Revenue")
                    Spacer()
                    Text(space.expectedRevenue > 0 ? (space.fixedRent / space.expectedRevenue).formattedPercentageWithDecimals : "#n/a")
                        .foregroundColor(space.fixedRent / space.expectedRevenue > 0.05 ? Color(UIColor.systemRed) : .secondary)
                }
                .foregroundColor(.secondary)
            }
            
            VStack(spacing: 8) {
                HStack {
                    Text("Combo Rent")
                    Spacer()
                    Text(userData.restaurant.currency.idd + space.comboRent.formattedGrouped)
                }
                
                HStack {
                    Text("Combo Rent to Revenue")
                    Spacer()
                    Text(space.expectedRevenue > 0 ? (space.comboRent / space.expectedRevenue).formattedPercentageWithDecimals : "#n/a")
                        .foregroundColor(space.expectedRevenue > 0 ? (space.comboRent / space.expectedRevenue > 0.05 ? Color(UIColor.systemRed) : .secondary) : .secondary)
                }
                .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Combo to Fixed Rent")
                Spacer()
                Text(space.fixedRent > 0 ? (space.comboRent / space.fixedRent).formattedPercentage : "#n/a")
            }
        }
    }
}

struct RentComparison_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            RentComparisonSection(space: .constant(Space(sample: true)))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
