//
//  ROIDistributionRowTESTING.swift
//  RFin
//
//  Created by Igor Malyarov on 19.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

import SwiftUI

fileprivate struct EmbedInStack: ViewModifier {
    private let verticalSizes: [ContentSizeCategory] = [
        .accessibilityMedium,
        .accessibilityLarge,
        .accessibilityExtraLarge,
        .accessibilityExtraExtraLarge,
        .accessibilityExtraExtraExtraLarge
    ]
    
    @Environment(\.sizeCategory) var sizeCategory
    
    func sizer() -> CGFloat {
        if verticalSizes.contains(sizeCategory) {
            return 2
        } else {
            return 1
        }
    }
    
    func body(content: Content) -> some View {
        if verticalSizes.contains(sizeCategory) {
            return AnyView(VStack { content })
        } else {
            return AnyView(HStack { content })
        }
    }
}

//extension Group where Content: View {
//    func embedInStack() -> some View {
//        ModifiedContent(content: self, modifier: EmbedInStack())
//    }
//}




struct ROIDistributionRowTESTING: View {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    
    var percentage1: Double
    var amount1: Double
    var percentage2: Double
    var amount2: Double
    
    let gap: CGFloat = 64 - 16
    
    var sizer2: CGFloat {
        let verticalSizes: [ContentSizeCategory] = [
            .accessibilityMedium,
            .accessibilityLarge,
            .accessibilityExtraLarge,
            .accessibilityExtraExtraLarge,
            .accessibilityExtraExtraExtraLarge
        ]
        
        if verticalSizes.contains(sizeCategory) {
            return 1.5
        } else {
            return 1
        }
    }
    
    var sizer: CGFloat { UIFontMetrics.default.scaledValue(for: 1) }
    
    var size: CGFloat = 12
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6 * self.sizer) {
            
            GeometryReader { geometry in
                if #available(iOS 14.0, *) {
                    HStack(spacing: 6 * self.sizer) {
                        Text(self.name)
                            .frame(width: (geometry.size.width - self.gap) / 7 * 2 * self.sizer + 6, alignment: .center)
                            //                        .border(Color.systemPink)
                            .foregroundColor(.systemBlue)
                        //                    Text(self.name)
                        //                        .frame(width: (geometry.size.width - self.gap) / 6, alignment: .trailing)
                        //                        .border(Color.systemPink)
                        //                        .foregroundColor(.systemPurple)
                        Text("o.partner")
                            .frame(width: (geometry.size.width - self.gap) / 6 * self.sizer, alignment: .trailing)
                            .foregroundColor(.systemBlue)
                        //                        .border(Color.systemPink)
                        Text("investor")
                            .frame(width: (geometry.size.width - self.gap) / 6 * self.sizer, alignment: .trailing)
                            .foregroundColor(.systemPurple)
                        //                        .border(Color.systemPink)
                        Spacer()
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            GeometryReader { geometry in
                HStack(spacing: 6 * self.sizer) {
                    Text(self.percentage1.formattedPercentage)
                        .frame(width: (geometry.size.width - self.gap) / 7 * self.sizer, alignment: .trailing)
                        .foregroundColor(.systemBlue)
                    //                        .border(Color.systemPink)
                    Text(self.percentage2.formattedPercentage)
                        .frame(width: (geometry.size.width - self.gap) / 7 * self.sizer, alignment: .leading)
                        .foregroundColor(.systemPurple)
                    //                        .border(Color.systemPink)
                    Text(self.amount1.smartNotation)
                        .frame(width: (geometry.size.width - self.gap) / 6 * self.sizer, alignment: .trailing)
                        .foregroundColor(.systemBlue)
                    //                        .border(Color.systemPink)
                    Text(self.amount2.smartNotation)
                        .frame(width: (geometry.size.width - self.gap) / 6 * self.sizer, alignment: .trailing)
                        .foregroundColor(.systemPurple)
                    //                        .border(Color.systemPink)
                    Spacer()
                }
                .font(.footnote)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        //        .border(Color.systemPink)
    }
}

struct ROIDistributionRowTESTING_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROIDistributionRowTESTING(name: "after", percentage1: 0.1, amount1: 888888888, percentage2: 1, amount2: 990_000)
                    .environment(\.sizeCategory, .extraExtraLarge)
                ROIDistributionRowTESTING(name: "after", percentage1: 0.1, amount1: 888888888, percentage2: 1, amount2: 990_000)
                    .environment(\.sizeCategory, .extraExtraExtraLarge)
                ROIDistributionRowTESTING(name: "after", percentage1: 0.1, amount1: 0, percentage2: 0.9, amount2: 9990_000)
                    .environment(\.sizeCategory, .accessibilityMedium)
                ROIDistributionRowTESTING(name: "before", percentage1: 0.1, amount1: 10_000, percentage2: 0.9, amount2: 990_000)
                    .environment(\.sizeCategory, .accessibilityLarge)
                ROIDistributionRowTESTING(name: "before", percentage1: 0.1, amount1: 10_000, percentage2: 0.9, amount2: 990_000)
                    .environment(\.sizeCategory, .accessibilityExtraLarge)
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
