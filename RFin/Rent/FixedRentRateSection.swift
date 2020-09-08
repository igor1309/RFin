//
//  FixedRentRate.swift
//  Rent
//
//  Created by Igor Malyarov on 27.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FixedRentRateSection: View {
    @EnvironmentObject var userData: UserData
    @Binding var space: Space
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Section(
            header: Text("Fixed Rent Rate"),
            footer: Text("Rent Rate per square meter per month.")
        ) {
            VStack(spacing: 8) {
                Stepper(
                    value: $space.area1,
                    in: 50...500,
                    step: 5
                ) {
                    RowWithDetail(systemName: "rectangle.split.3x1.fill", title: "Space, sq m", detail: space.area1.formattedGrouped)
                }
                
                Stepper(
                    value: $space.area1FixedRentRate,
                    in: currency == .rub ? 500...10_000 : 1...70,
                    step: currency == .rub ? 500 : 0.5
                ) {
                    RowWithDetail(systemName: "rectangle.split.3x1.fill", title: "Rent Rate", detail: currency.idd + space.area1FixedRentRate.smartFormatted)
                }
                .contextMenu {
                    Button {
                        if self.currency == .rub {
                            self.space.area1FixedRentRate = 5_000
                        } else {
                            self.space.area1FixedRentRate = 25
                        }
                    } label: {
                        Label("Set rate at \(currency.idd)\(currency == .rub ? "5000" : "25")", systemImage: "arrow.counterclockwise.circle")
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
                    value: $space.area2FixedRentRate,
                    in: currency == .rub ? 100...10_000 : 1...70,
                    step: currency == .rub ? 200 : 0.5
                ) {
                    RowWithDetail(systemName: "table", title: "Rent Rate", detail: currency.idd + space.area2FixedRentRate.smartFormatted, isSecondary: true)
                }
                .contextMenu {
                    Button {
                        if self.currency == .rub {
                            self.space.area2FixedRentRate = 2_000
                        } else {
                            self.space.area2FixedRentRate = 8
                        }
                    } label: {
                        Label("Set rate at \(currency.idd)\(currency == .rub ? "2000" : "8")", systemImage: "arrow.counterclockwise.circle")
                    }
                }
            }
        }
    }
}


struct FixedRentRate_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FixedRentRateSection(space: .constant(Space(sample: true)))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
