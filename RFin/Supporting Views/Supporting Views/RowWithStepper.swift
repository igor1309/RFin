//
//  RowWithStepper.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RowWithAmountAndStepperPercentage4: View {
    var title: String
    var currency: Currency
    @Binding var amount: Int
    var percentage: Double
    var step: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(verbatim: title)
                Spacer()
                Text(currency.idd + amount.threeSignificantDigits)
//                    .font(.callout)
                    .foregroundColor(.orange)
                Text(percentage.formattedPercentageWithDecimals)
//                    .font(.callout)
                    .foregroundColor(.secondary)
                    .frame(width: 70, alignment: .trailing)
            }
            HStack {
                Spacer()
                Stepper("Stepper for amount", onIncrement: {
                    self.amount += self.step
                }, onDecrement: {
                    if self.amount > self.step {
                        self.amount -= self.step
                    }
                })
                    .labelsHidden()
            }
        }
        .font(.subheadline)
    }
}

struct RowWithAmountAndStepperPercentage3: View {
    var title: String
    var currency: Currency
    var amount: Double
    @Binding var percentage: Double
    var step: Double = 0.001
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(verbatim: title)
                Spacer()
                Text(currency.idd + amount.threeSignificantDigits)
//                    .font(.callout)
                    .foregroundColor(.secondary)
                Text(percentage.formattedPercentageWithDecimals)
                    .foregroundColor(.orange)
//                    .font(.callout)
                    .frame(width: 70, alignment: .trailing)
            }
            HStack {
                Spacer()
                Stepper("Stepper for amount", onIncrement: {
                    self.percentage += self.step
                }, onDecrement: {
                    if self.percentage > self.step {
                        self.percentage -= self.step
                    }
                })
                    .labelsHidden()
            }
        }
        .font(.subheadline)
            
        .contextMenu {
            Button(action: { self.percentage = 0.01 }) {
                HStack {
                    Text("1%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            Button(action: { self.percentage = 0.05 }) {
                HStack {
                    Text("5%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
//            Button(action: { self.percentage = 0.10 }) {
//                HStack {
//                    Text("10%")
//                    Image(systemName: "arrowshape.turn.up.left")
//                }
//            }
//            Button(action: { self.percentage = 0.15 }) {
//                HStack {
//                    Text("15%")
//                    Image(systemName: "arrowshape.turn.up.left")
//                }
//            }
            Button(action: { self.percentage = 0.20 }) {
                HStack {
                    Text("20%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            Button(action: { self.percentage = 0.25 }) {
                HStack {
                    Text("25%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            Button(action: { self.percentage = 0.30 }) {
                HStack {
                    Text("30%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            Button(action: { self.percentage = 0.35 }) {
                HStack {
                    Text("35%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            Button(action: { self.percentage = 0.40 }) {
                HStack {
                    Text("40%")
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
        }
    }
}

struct RowWithAmountAndStepperPercentage2: View {
    var title: String
    var currency: Currency
    var amount: Double
    @Binding var percentage: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(verbatim: title)
                Spacer()
                Text(currency.idd + amount.formattedGrouped)
                    .font(.callout)
            }
            HStack {
                Spacer()
                Text(percentage.formattedPercentageWithDecimals)
                    .foregroundColor(.orange)
                    .font(.callout)
                Stepper("Stepper for amount", onIncrement: {
                    self.percentage += 0.001
                }, onDecrement: {
                    if self.percentage > 0.001 {
                        self.percentage -= 0.001
                    }
                })
                    .labelsHidden()
            }
        }
    }
}

struct RowWithAmountAndStepperPercentage: View {
    var currency: Currency
    var amount: Double
    @Binding var percentage: Double
    
    var body: some View {
        Stepper(onIncrement: {
            self.percentage += 0.001 },
                onDecrement: {
                    if self.percentage > 0.001 {
                        self.percentage -= 0.001 }}
        ) {
                            HStack {
                                Text(currency.idd + amount.formattedGrouped)
                                    .frame(width: 120, alignment: .trailing)
                                Spacer()
                                Text(percentage.formattedPercentageWithDecimals)
                                    .foregroundColor(.orange)
                            }
        }
    }
}

struct RowWithStepperDouble: View {
    var title: String
    var currency: Currency
    @Binding var amount: Double
    var step: Double = 0.10
    
    var body: some View {
        Stepper(onIncrement: {
            self.amount += self.step
        }, onDecrement: {
            if self.amount > self.step {
                self.amount -= self.step
            }
        }) {
            HStack {
                Text(title)
                Spacer()
                Text(currency.idd + amount.threeSignificantDigits)
                    .foregroundColor(.orange)
            }
        }
    }
}

struct RowWithStepperPercentage: View {
    var title: String
    @Binding var amount: Double
    var step: Double = 0.001
    
    var body: some View {
        Stepper(onIncrement: {
            self.amount += self.step
        }, onDecrement: {
            if self.amount > self.step {
                self.amount -= self.step
            }
        }) {
            HStack {
                Text(title)
                Spacer()
                Text(amount.formattedPercentageWithDecimals)
                    .foregroundColor(.orange)
            }
        }
    }
}

struct RowWithStepperInt: View {
    var title: String
    var currency: Currency
    @Binding var amount: Int
    var step: Int = 1
    
    var body: some View {
        Stepper(onIncrement: {
            self.amount += self.step
        }, onDecrement: {
            if self.amount > self.step {
                self.amount -= self.step }})
        {
            HStack {
                Text(title)
                Spacer()
                Text(currency.idd + amount.formattedGrouped)
                    .foregroundColor(.orange)
            }
        }
    }
}

struct RowWithStepperInt2: View {
    var title: String
    var currency: Currency
    @Binding var amount: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Text(currency.idd + amount.formattedGrouped)
                    .foregroundColor(.orange)
            }
            HStack {
                Spacer()
                Stepper("Stepper for amount", onIncrement: {
                    self.amount += 1
                }, onDecrement: {
                    if self.amount > 1 {
                        self.amount -= 1
                    }
                })
                    .labelsHidden()
            }
        }
    }
}

struct RowWithStepper_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                RowWithAmountAndStepperPercentage4(title: "New row with Stepper 4", currency: .euro, amount: .constant(123_456), percentage: 0.123)
                RowWithAmountAndStepperPercentage3(title: "New row with Stepper 3", currency: .euro, amount: 123_456, percentage: .constant(0.123))
                RowWithAmountAndStepperPercentage2(title: "New row with Stepper 2", currency: .euro, amount: 123_456, percentage: .constant(0.123))
                RowWithAmountAndStepperPercentage(currency: .euro, amount: 123_456, percentage: .constant(0.123))
                RowWithStepperPercentage(title: "Percentage", amount: .constant(0.3456))
                RowWithStepperDouble(title: "Double", currency: Currency.euro, amount: .constant(1_000.34))
                RowWithStepperInt2(title: "Int 2", currency: Currency.usd, amount: .constant(100_000))
                RowWithStepperInt(title: "Int", currency: Currency.usd, amount: .constant(100_000))
            }
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
