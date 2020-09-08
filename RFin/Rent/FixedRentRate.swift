//
//  FixedRentRate.swift
//  Rent
//
//  Created by Igor Malyarov on 27.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FixedRentRate: View {
    @EnvironmentObject var userData: UserData
    @Binding var space: Space
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        Section(header: Text("Fixed Rent Rate".uppercased()),
                footer: Text("Rent Rate per square meter per month.")
        ) {
            VStack(spacing: 8) {
                Stepper(value: $space.area1, in: 50...500, step: 5) {
                    HStack {
                        Image(systemName: "rectangle.split.3x1.fill")
                        Row(title: "Space", detail: space.area1.formattedGrouped + " sq m")
                    }
                }
                
                Stepper(value: $space.area1FixedRentRate, in: currency == .rub ? 500...10_000 : 1...70, step: currency == .rub ? 500 : 0.5) {
                    HStack {
                        Image(systemName: "rectangle.split.3x1.fill")
                        Row(title: "Rent Rate",
                            detail: currency.idd + space.area1FixedRentRate.smartFormatted)
                    }
                }
                .contextMenu {
                    Button(action: {
                        if self.currency == .rub {
                            self.space.area1FixedRentRate = 5_000
                        } else {
                            self.space.area1FixedRentRate = 25
                        }
                    }) {
                        HStack {
                            Text("Set rate at \(currency.idd)\(currency == .rub ? "5000" : "25")")
                            Image(systemName: "arrow.counterclockwise.circle")
                        }
                    }
                }
            }
            
            VStack(spacing: 8) {
                Stepper(value: $space.area2, in: 0...200, step: 5) {
                    HStack {
                        Image(systemName: "table").foregroundColor(.secondary)
                        Row(title: "Space", detail: space.area2.formattedGrouped + " sq m", isSecondary: true)
                    }
                }
                
                Stepper(value: $space.area2FixedRentRate, in: currency == .rub ? 100...10_000 : 1...70, step: currency == .rub ? 200 : 0.5) {
                    HStack {
                        Image(systemName: "table").foregroundColor(.secondary)
                        Row(title: "Rent Rate",
                            detail: currency.idd + space.area2FixedRentRate.smartFormatted,
                            isSecondary: true)
                    }
                }
                .contextMenu {
                    Button(action: {
                        if self.currency == .rub {
                            self.space.area2FixedRentRate = 2_000
                        } else {
                            self.space.area2FixedRentRate = 8
                        }
                    }) {
                        HStack {
                            Text("Set rate at \(currency.idd)\(currency == .rub ? "2000" : "8")")
                            Image(systemName: "arrow.counterclockwise.circle")
                        }
                    }
                }
            }
        }
    }
}

struct FixedRentRate_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FixedRentRate(space: .constant(Space(sample: true)))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
