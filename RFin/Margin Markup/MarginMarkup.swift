//
//  MarginMarkup.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI
import SwiftPI

struct MarginMarkup: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentation
    
    struct Ratio: Hashable {
        var markup: Double
        
        var margin: Double {
            get { 1 - 1/(markup + 1) }
            set { markup = newValue < 1 ? 1/(1 - newValue) - 1 : 0 }
        }
        
        init(markup: Double) {
            self.markup = markup
        }
        
        init?(margin: Double) {
            guard margin > 0 && margin < 1 else {
                return nil
            }
            self.init(markup: 10/100)
            self.margin = margin
        }
    }
    
    @State var ratio = Ratio(markup: 3.00)
    
    private let values1: [Double] = [20, 25, 33, 50, 75, 80].map { $0/100 }
    private let values2: [Double] = [100, 125, 150, 175, 200, 250].map { $0/100 }
    private let values3: [Double] = [300, 350, 400, 450, 500].map { $0/100 }
    private var values: [Double] { values1 + values2 + values3 }
    
    
    struct Pair: Hashable {
        var markup: Double
        var margin: Double
        
        init(markup: Double, margin: Double) {
            self.markup = markup
            self.margin = margin
        }
        
        init?(markup: Double?, margin: Double) {
            guard let markup = markup else {
                return nil
            }
            
            self.init(markup: markup, margin: margin)
        }
    }
    
    private var tableValues: [Pair] {
        values.map {
            Pair(markup: $0, margin: Ratio(markup: $0).margin)
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Spacer()
                item(ratio.markup * 100, title: "Markup")
                Spacer()
                item(ratio.margin * 100, title: "Margin")
                Spacer()
                item((1 - ratio.margin) * 100, title: "cost")
                Spacer()
            }
            
            Divider().padding(.vertical)
            
            ScrollView(showsIndicators: false) {
                Group {
                    
                    if sizeClass == .compact {
                        compactInputView("Markup", value: $ratio.markup, in: 0...50, step: 0.01)
                        picker(values1)
                        picker(values2)
                        picker(values3)
                        
                        Divider().padding(.vertical)
                        
                        compactInputView("Margin", value: $ratio.margin, in: 0...0.9999999, step: 0.005)
                    } else {
                        VStack(spacing: 0) {
                            inputView("Markup", value: $ratio.markup, in: 0...50, step: 0.01, values: values)
                            
                            Divider()
                            
                            inputView("Margin", value: $ratio.margin, in: 0...0.9999999, step: 0.005, values: values.filter { $0 < 1 })
                        }
                    }
                }
            }
                        
            Divider().padding(.vertical)
            
            markupMarginTable()
            
            if sizeClass == .regular {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .navigationTitle("Margin & Markup")
        .navigationBarItems(trailing: trailingButton)
    }
    
    private func item(_ item: Double, title: String) -> some View {
        VStack {
            Text("\(item, specifier: "%.f%%")")
                .foregroundColor(.systemTeal)
                .font(.system(size: 36, weight: .semibold, design: .rounded))
            Text(title.uppercased())
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
    
    private func compactInputView(_ title: String, value: Binding<Double>, in range: ClosedRange<Double>, step: Double) -> some View {
        VStack {
            Stepper(value: value, in: range, step: step) {
                Text("\(title): \(value.wrappedValue * 100, specifier: "%.1f%%")")
                    .foregroundColor(.systemOrange)
            }
            Slider(value: value, in: range, step: step)
                .accentColor(.systemOrange)
        }
    }
    
    private func inputView(_ title: String, value: Binding<Double>, in range: ClosedRange<Double>, step: Double, values: [Double]) -> some View {
        HStack {
            compactInputView(title, value: value, in: range, step: step)
            
            Spacer(minLength: 32)
            
            Picker("Markup", selection: value) {
                ForEach(values, id: \.self) { value in
                    Text("\(value * 100, specifier: "%.f%%")").tag(value)
                }
            }
        }
    }
    
    private func markupMarginTable() -> some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading ,spacing: 4) {
                Text("Markup")
                Text("Margin")
            }
            .font(.footnote)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(tableValues, id: \.self) { value in
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("\(value.markup * 100, specifier: "%.f%%")")
                            Text("\(value.margin * 100, specifier: "%.f%%")")
                        }
                        .font(.footnote)
                    }
                }
            }
        }
    }
    
    private func picker(_ values: [Double]) -> some View {
        Picker("", selection: $ratio.markup) {
            ForEach(values, id: \.self) { value in
                Text("\(value * 100, specifier: "%.f%%")").tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    @ViewBuilder
    var trailingButton: some View {
        if sizeClass == .compact {
            TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct MarginMarkup_Previews: PreviewProvider {
    static var previews: some View {
        MarginMarkup()
            .preferredColorScheme(.dark)
    }
}
