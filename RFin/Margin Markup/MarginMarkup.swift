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
    }
    
    @State var ratio = Ratio(markup: 3.00)
    
    private let values1: [Double] = [20, 25, 50, 75, 100, 150].map { $0/100 }
    private let values2: [Double] = [200, 250, 300, 350, 400, 500].map { $0/100 }
    
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
            
            Group {
                
                if sizeClass == .compact {
                    markupStepper()
                    markupSlider()
                    picker(values1)
                    picker(values2)
                } else {
                    markupStepperSlider()
                    picker(values1 + values2)
                }
                
            }
            
            Divider().padding(.vertical)
            
            marginStepperSlider()
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        .navigationTitle("Margin & Markup")
        .navigationBarItems(trailing: trailing)
    }
    
    private func item(_ item: Double, title: String) -> some View {
        VStack {
            Text("\(item, specifier: "%.f%%")")
                .font(.system(size: 36, weight: .semibold, design: .rounded))
            Text(title.uppercased())
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
    
    private func picker(_ values: [Double]) -> some View {
        Picker("Markup", selection: $ratio.markup) {
            ForEach(values, id: \.self) { value in
                Text("\(value * 100, specifier: "%.f%%")").tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private func markupStepper() -> some View {
        Stepper(value: $ratio.markup, in: 0...10, step: 0.01) {
            Text("Markup: \(ratio.markup * 100, specifier: "%.1f%%")")
                .foregroundColor(.systemOrange)
        }
    }
    
    private func markupStepperSlider() -> some View {
        Stepper(value: $ratio.markup, in: 0...10, step: 0.01) {
            Text("Markup: \(ratio.markup * 100, specifier: "%.1f%%")")
                .foregroundColor(.systemOrange)
            markupSlider()
        }
    }
    
    private func markupSlider() -> some View {
        Slider(value: $ratio.markup, in: 0...10, step: 0.01)
            .accentColor(.systemOrange)
    }
    
    private func marginSlider() -> some View {
        Slider(value: $ratio.margin, in: 0...0.9999999, step: 0.005)
            .accentColor(.systemOrange)
    }
    
    @ViewBuilder
    private func marginStepperSlider() -> some View {
        if sizeClass == .compact {
            HStack {
                Text("Margin: \(ratio.margin * 100, specifier: "%.1f%%")")
                    .foregroundColor(.systemOrange)
                Spacer()
                Text("Cost: \((1 - ratio.margin) * 100, specifier: "%.1f%%")")
                    .foregroundColor(.secondary)
            }
            
            marginSlider()
                .padding(.bottom)
        } else {
            Stepper(value: $ratio.margin, in: 0...10, step: 0.01) {
                Text("Margin: \(ratio.margin * 100, specifier: "%.1f%%")")
                    .foregroundColor(.systemOrange)
                marginSlider()
            }
        }
    }
    
    @ViewBuilder
    var trailing: some View {
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
