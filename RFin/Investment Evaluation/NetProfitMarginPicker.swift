//
//  NetProfitMarginPicker.swift
//  Investment Evaluation
//
//  Created by Igor Malyarov on 20.07.2020.
//

import SwiftUI

struct NetProfitMarginPicker: View {
    @Binding var netProfitMargin: Double
    
    private let margins: [Double] = [5, 7, 10, 12, 15, 20].map { $0/100 }
    
    var body: some View {
        Picker("Net Profit Margin", selection: $netProfitMargin) {
            ForEach(margins, id: \.self) { margin in
                Text("\(margin * 100, specifier: "%.f%%")").tag(margin)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct NetProfitMarginPicker_Previews: PreviewProvider {
    static var previews: some View {
        NetProfitMarginPicker(netProfitMargin: .constant(0.10))
    }
}
