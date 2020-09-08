//
//  FlowTableRow.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FlowTableRow: View {
    var text: String
    var when: String
    var flow1: Double
    var flow2: Double
    var flowName: String
    var isHeader: Bool
    var isFooter: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Text(text)
                .frame(minWidth: 18, alignment: isHeader ? .center : .trailing)
                .foregroundColor(isHeader || isFooter ? .primary : .secondary)
            
            Text(when)
                .frame(minWidth: 56, alignment: isHeader ? .leading : .leading)
                .foregroundColor(isHeader || isFooter ? .primary : .systemTeal)
//            .border(Color.systemPink)
            
            Text(isHeader ? "investor" : flow1.formattedGrouped)
                .frame(minWidth: 98, alignment: isHeader ? .center : .trailing)
                .foregroundColor(isHeader || isFooter ? .primary : flow1 > 0 ? .systemGreen : (flow1 == 0 ? .secondary : .systemRed))
            
            Text(isHeader ? "op" : flow2.formattedGrouped)
                .frame(minWidth: 98, alignment: isHeader ? .center : .trailing)
                .foregroundColor(isHeader || isFooter ? .primary : .secondary)
            
            Text(flowName)
                .padding(.leading, isHeader ? 12 : 6)
                .foregroundColor(isHeader || isFooter ? .primary : .systemPurple)
        }
    }
}

struct FlowTableRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 8) {
                    
                    FlowTableRow(text: "#", when: "when", flow1: 10_000_000, flow2: 8_000_000, flowName: "flow", isHeader: true, isFooter: false)
                        .font(.system(size: 8, weight: Font.Weight.regular, design: .monospaced))
                    Group {
                        FlowTableRow(text: "10", when: "Y3 Q4", flow1: 10_000_000, flow2: 8_000_000, flowName: "init", isHeader: false, isFooter: false)
                        FlowTableRow(text: "10", when: "Y3 Q4", flow1: 10_000_000, flow2: 8_000_000, flowName: "grace", isHeader: false, isFooter: false)
                    }
                    .font(.system(size: 14, weight: Font.Weight.regular, design: .monospaced))
                    FlowTableRow(text: "", when: "total", flow1: 10_000_000, flow2: 8_000_000, flowName: "", isHeader: false, isFooter: true)
                        .font(.system(size: 14, weight: Font.Weight.regular, design: .monospaced))
                }
            }
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
