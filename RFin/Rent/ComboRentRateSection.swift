//
//  ComboRentRate.swift
//  Rent
//
//  Created by Igor Malyarov on 27.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ComboRentRateSection: View {
    @EnvironmentObject var userData: UserData
    @Binding var space: Space
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Section(
            header: Text("Combo Rent Rate"),
            footer: Text("Cut is an Extra Rent as percentage of Revenue in addition to Fixed Rent Rate (per month).")
        ) {
            Stepper(
                value: $space.revenueCut,
                in: 0...0.2,
                step: 0.001
            ) {
                RowWithDetail(systemName: "scissors", title: "Cut", detail: space.revenueCut.formattedPercentageWithDecimals)
            }
            
            VStack(spacing: 8) {
                Stepper(
                    value: $space.area1,
                    in: 50...500, step: 5
                ) {
                    RowWithDetail(systemName: "rectangle.split.3x1.fill", title: "Space, sq m", detail: space.area1.formattedGrouped)
                }
                
                Stepper(
                    value: $space.area1, in: 50...500,
                    step: 5
                ) {
                    RowWithDetail(systemName: "rectangle.split.3x1.fill", title: "Space, sq m", detail: space.area1.formattedGrouped)
                }
                
                Stepper(
                    value: $space.area1ComboRentRate,
                    in: currency == .rub ? 500...10_000 : 1...70,
                    step: currency == .rub ? 500 : 0.5
                ) {
                    RowWithDetail(systemName: "rectangle.split.3x1.fill", title: "Rent Rate", detail: userData.restaurant.currency.idd + space.area1ComboRentRate.smartFormatted)
                }
                .contextMenu {
                    Button {
                        if self.currency == .rub {
                            self.space.area1ComboRentRate = 3_500
                        } else {
                            self.space.area1ComboRentRate = 25
                        }
                    } label: {
                        Label("Set rate at \(currency.idd)\(currency == .rub ? 3_500.formattedGrouped : "25")", systemImage: "arrow.counterclockwise.circle")
                    }
                }
            }
            
            VStack(spacing: 8) {
                Stepper(
                    value: $space.area2,
                    in: 0...200,
                    step: 5
                ) {
                    RowWithDetail(systemName: "table", title: "Space, sq m", detail: space.area2.formattedGrouped, isSecondary: true)
                }
                
                Stepper(
                    value: $space.area2ComboRentRate,
                    in: currency == .rub ? 100...10_000 : 1...70,
                    step: currency == .rub ? 200 : 0.5
                ) {
                    RowWithDetail(systemName: "table", title: "Rent Rate", detail: userData.restaurant.currency.idd + space.area2ComboRentRate.smartFormatted, isSecondary: true)
                }
                .contextMenu {
                    Button {
                        if self.currency == .rub {
                            self.space.area2ComboRentRate = 500
                        } else {
                            self.space.area2ComboRentRate = 8
                        }
                    } label: {
                        Label("Set rate at \(currency.idd)\(currency == .rub ? 500.formattedGrouped : "8")", systemImage: "arrow.counterclockwise.circle")
                    }
                }
            }
        }
    }
}

struct ComboRentRate_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ComboRentRateSection(space: .constant(Space(sample: true)))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
