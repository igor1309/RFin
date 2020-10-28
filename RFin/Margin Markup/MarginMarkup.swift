//
//  MarginMarkup.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI
import SwiftPI

struct Ratio: Hashable {
    var markup: Double
    
    var margin: Double {
        get { 1 - 1/(markup + 1) }
        set { markup = newValue < 1 ? 1/(1 - newValue) - 1 : 0 }
    }
}

struct MarginMarkup: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentation
    
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
                Stepper("Markup: \(ratio.markup * 100, specifier: "%.1f%%")", value: $ratio.markup, in: 0...10, step: 0.01)
                
                Picker("Markup", selection: $ratio.markup) {
                    ForEach(values1, id: \.self) { value in
                        Text("\(value * 100, specifier: "%.f%%")").tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Markup", selection: $ratio.markup) {
                    ForEach(values2, id: \.self) { value in
                        Text("\(value * 100, specifier: "%.f%%")").tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Slider(value: $ratio.markup, in: 0...10, step: 0.01)
            }
            
            Divider().padding(.vertical)
            
            HStack {
                Text("Margin: \(ratio.margin * 100, specifier: "%.1f%%")")
                Spacer()
                Text("Cost: \((1 - ratio.margin) * 100, specifier: "%.1f%%")")
            }
            
            Slider(value: $ratio.margin, in: 0...0.9999999, step: 0.005)
                .padding(.bottom)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        .navigationTitle("Margin & Markup")
        .navigationBarItems(trailing: trailing)
    }
    
    @ViewBuilder
    var trailing: some View {
        if sizeClass == .compact {
            TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
    
    private func item(_ item: Double, title: String) -> some View {
        VStack {
            Text("\(item, specifier: "%.f%%")")
                .foregroundColor(.systemOrange)
                .font(.largeTitle)
            Text(title.uppercased())
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
}

struct MarginMarkup_Previews: PreviewProvider {
    static var previews: some View {
        MarginMarkup()
            .preferredColorScheme(.dark)
    }
}
