//
//  ROIDetailFlowsSection.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ROIDetailFlowsSection: View {
    var otbivka: Otbivka
    
    var body: some View {
        Section(header: Text("Monthly Flows".uppercased()).padding(.top)) {
            VStack(alignment: .leading, spacing: 8) {
                
                FlowTableRow(text: "#", when: "when", flow1: -1, flow2: -1, flowName: "flow", isHeader: true, isFooter: false)
                    .font(.system(size: 8, weight: Font.Weight.regular, design: .monospaced))
                
                Divider()
                
                ForEach(otbivka.flows.indices, id: \.self) { index in
                    
                    FlowTableRow(text: index.formattedGrouped, when: self.monthNoToWords(index), flow1: self.otbivka.flows[index].flowToInvestor, flow2: self.otbivka.flows[index].flowToOP, flowName: self.otbivka.flows[index].name, isHeader: false, isFooter: false)
                        .font(.system(size: 14, weight: Font.Weight.regular, design: .monospaced))
                }
                
                Divider()
                
                FlowTableRow(text: "", when: "total", flow1: otbivka.investorsDistribution, flow2: otbivka.opDistribution, flowName: "", isHeader: false, isFooter: true)
                    .font(.system(size: 14, weight: Font.Weight.regular, design: .monospaced))
                
                FlowTableRow(text: "", when: "net", flow1: otbivka.investorsProfit, flow2: otbivka.opDistribution, flowName: "", isHeader: false, isFooter: true)
                    .font(.system(size: 14, weight: Font.Weight.regular, design: .monospaced))
            }
            .padding(.vertical, 3)
            .onAppear {
                #if DEBUG
                self.exportFlows()
                #endif
            }
        }
    }
    
    private func monthNoToWords(_ monthNo: Int) -> String {
        if monthNo == 0 {
            return "Start"
        } else {
            let y = "y\((monthNo / 12).formattedGrouped)"
            let month = monthNo % 12
            let m = "m\(month == 0 ? "12" : String(format: "%02d", month))"
            
            return "\(y) \(m)"
        }
    }
    
    private func exportFlows() {
        let str = otbivka.flows.map { String($0.flowToInvestor) }.joined(separator: ",")
        let filename = getDocumentsDirectory().appendingPathComponent("flows.csv")

        do {
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            print("Flows exported to file \(filename)")
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            print("error exportin flows")
        }
    }
}

struct ROIDetailFlowsSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ROIDetailFlowsSection(otbivka: sampleROICollection.otbivki[0])
            }
            .navigationBarTitle(Text("Flows"), displayMode: .inline)
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
