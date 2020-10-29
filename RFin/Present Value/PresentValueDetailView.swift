//
//  PresentValueDetailView.swift
//  PresentValue
//
//  Created by Igor Malyarov on 15.02.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PresentValueDetailView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var presentValueData: PresentValueData
    
    let payments: [Double] = [1, 3, 5, 10, 20, 50, 100]
    let lifetimes: [Int] = [1, 2, 5, 10, 20, 40]
    let rates: [Double] = [3/100, 6/100, 9/100, 12/100, 18/100]
    let multipliers = [10, 100, 1_000, 1_000_000, 1_000_000_000]
    
    var body: some View {
        List {
            if sizeClass == .compact {
                compactHeader()
                block("Payment Amount") { amountPicker() }
                block("Payment Period") { periodPicker() }
                block("Lifetime") { lifetimePicker() }
                block("Annual Discount Rate") { ratePicker() }
                block("Multiplier") { multiplierPicker() }
            } else {
                HStack(alignment: .top) {
                    VStack(spacing: 32) {
                        block("Payment Amount") { amountPicker() }
                        block("Payment Period") { periodPicker() }
                        block("Annual Discount Rate") { ratePicker() }
                    }
                    
                    Spacer(minLength: 32)
                    
                    VStack(spacing: 32) {
                        block("Lifetime") { lifetimePicker() }
                        block("Multiplier") { multiplierPicker() }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())        
        .navigationBarTitle(Text("Present Value"), displayMode: sizeClass == .compact ? .large : .inline)
        .navigationBarItems(trailing: trailing)
    }
    
    @ViewBuilder
    private func block<V: View>(_ title: String, picker: @escaping () -> V) -> some View {
        if sizeClass == .compact {
            Section(header: Text(title)) {
                picker()
            }
        } else {
            VStack {
                Text(title.uppercased())
                    .foregroundColor(.secondary)
                    .font(.footnote)
                picker()
            }
        }
    }
    
    private func compactHeader() -> some View {
        Section(
            //header: Text("Present Value"),
            footer: Text(presentValueData.rccf.explanation() + " ").foregroundColor(.primary)
                + Text(presentValueData.rccf.explanation(presentValueData.multiplier))
        ) {
            HStack {
                Text("Payment PV")
                Spacer()
                Text(presentValueData.rccf.pv.formattedGrouped)
            }
            .font(.headline)
            .foregroundColor(.systemYellow)
        }
    }
    
    private func amountPicker() -> some View {
        Picker(selection: $presentValueData.rccf.payment, label: Text("Payment Amount")) {
            ForEach(payments, id: \.self) { payment in
                Text("\(Int(payment))").tag(payment)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private func periodPicker() -> some View {
        Picker(selection: $presentValueData.rccf.period, label: Text("Payment Period")) {
            ForEach(RegularConstantCashFlow.Period.allCases, id: \.self) { period in
                Text(period.id).tag(period)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
    
    @ViewBuilder
    private func lifetimePicker() -> some View {
        Picker(selection: $presentValueData.rccf.lifetimeType, label: Text("Lifetime Type")) {
            ForEach(RegularConstantCashFlow.LifetimeType.allCases, id: \.self) { lifetimeType in
                Text(lifetimeType.id).tag(lifetimeType)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
        
        if presentValueData.rccf.lifetimeType != .perpetual {
            Picker(selection: $presentValueData.rccf.lifetime, label: Text("Lifetime in Years")) {
                ForEach(lifetimes, id: \.self) { lifetime in
                    Text("\(lifetime.formattedGrouped)").tag(lifetime)
                }
            }
            .labelsHidden()
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private func ratePicker() -> some View {
        Picker(selection: $presentValueData.rccf.annualRate, label: Text("Annual Discount Rate")) {
            ForEach(rates, id: \.self) { rate in
                Text(rate.formattedPercentage).tag(rate)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private func multiplierPicker() -> some View {
        Picker(selection: $presentValueData.multiplier, label: Text("Multiplier")) {
            ForEach(multipliers, id: \.self) { multiplier in
                Text(multiplier.threeSignificantDigits).tag(multiplier)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
    
    @ViewBuilder
    private var trailing: some View {
        TrailingButton("Done") {
            self.presentation.wrappedValue.dismiss()
        }
    }
}

struct PresentValueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PresentValueDetailView()
                .previewDevice("iPhone 12 Pro")
                .preferredColorScheme(.dark)
                .environmentObject(PresentValueData())
            PresentValueDetailView()
                .preferredColorScheme(.dark)
                .environmentObject(PresentValueData())
        }
    }
}
