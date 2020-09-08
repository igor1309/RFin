//
//  ROISplit.swift
//  RFin
//
//  Created by Igor Malyarov on 20.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
let testingFont: Font = .title2//.fontWeight(.semibold)

struct ElementWithTitle: View {
    var title: String
    var valueAsString: String
    var color: Color
    var alignment: HorizontalAlignment = .center
    
    var body: some View {
        VStack(alignment: alignment, spacing: 0) {
            if #available(iOS 14.0, *) {
                Text(title)//.uppercased())
                    .font(.caption2)
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 14.0, *) {
                Text(valueAsString)
                    .font(testingFont)
            } else {
                // Fallback on earlier versions
            }
            //                .font(.headline)
        }
        .foregroundColor(color)
    }
}

struct ROISplit: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Text("before").foregroundColor(.systemTeal).font(.caption2)
                        Spacer()
                        Text("partner").foregroundColor(.systemIndigo)
                            + Text("/").foregroundColor(.systemGray)
                            + Text("investor").foregroundColor(.systemPurple)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 14.0, *) {
                    HStack {
                        Text(10.formattedGrouped).foregroundColor(.systemIndigo)
                            + Text("/").foregroundColor(.systemGray)
                            + Text(90.formattedGrouped).foregroundColor(.systemPurple)
                        Spacer()
                        Text(1_200_000.smartNotation).foregroundColor(.systemIndigo)
                            + Text("/").foregroundColor(.systemGray)
                            + Text(2_000_000.smartNotation).foregroundColor(.systemPurple)
                    }
                    .font(testingFont)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            Divider().padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Text("after").foregroundColor(.systemTeal).font(.caption2)
                        Spacer()
                        Text("partner").foregroundColor(.systemIndigo)
                            + Text("/").foregroundColor(.systemGray)
                            + Text("investor").foregroundColor(.systemPurple)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 14.0, *) {
                    HStack {
                        Text(10.formattedGrouped).foregroundColor(.systemIndigo)
                            + Text("/").foregroundColor(.systemGray)
                            + Text(90.formattedGrouped).foregroundColor(.systemPurple)
                        Spacer()
                        Text(1_200_000.smartNotation).foregroundColor(.systemIndigo)
                            + Text("/").foregroundColor(.systemGray)
                            + Text(2_000_000.smartNotation).foregroundColor(.systemPurple)
                    }
                    .font(testingFont)
                } else {
                    // Fallback on earlier versions
                }
                
            }
        }
    }
}

struct ROISplit2: View {
    @EnvironmentObject var settings: SettingsStore
    var otbivka: Otbivka
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ElementWithTitle(title: "return", valueAsString: otbivka.yearsToReturnInvestment.formattedGroupedWith1Decimal + "y", color: .systemOrange)
                Spacer()
                ElementWithTitle(title: "grace", valueAsString: otbivka.gracePeriodInYears.formattedGroupedWith1Decimal + "y", color: .secondary)
                Spacer()
                ElementWithTitle(title: "horizon", valueAsString: otbivka.estimationPeriodInYears.formattedGroupedWithMax2Decimals + "y", color: .primary)
                Spacer()
                Group {
                    ElementWithTitle(title: "irr", valueAsString: otbivka.irr?.formattedPercentageWith1Decimal ?? "n/a", color: .yellow)
                    Spacer()
                    ElementWithTitle(title: "profit", valueAsString: otbivka.investorsProfit.smartNotation, color: .green)
                }
            }
            
            ROISplit3(otbivka: otbivka)
        }
    }
}

struct ROISplit3: View {
    var otbivka: Otbivka
    
    var body: some View {
        HStack {
            BeforeAfterTotalStack(title: "distribution", split: " ", monthly: "monthly".uppercased(), yearly: "yearly".uppercased(), total: "total".uppercased(), isHeader: true)
                .foregroundColor(.secondary)
            
            Spacer()
            
            BeforeAfterTotalStack(
                title: "before",
                split: "\((otbivka.opShareBeforeReturn * 100).formattedGrouped)/\((otbivka.investorsShareBeforeReturn * 100).formattedGrouped)",
                monthly: "\(otbivka.opDistributionPerMonthBeforeReturn.threeSignificantDigits)/\(otbivka.investorsDistributionPerMonthBeforeReturn.threeSignificantDigits)",
                yearly: "\(otbivka.opDistributionPerYearBeforeReturn.smartNotation)/\(otbivka.investorsDistributionPerYearBeforeReturn.smartNotation)",
                total: " ")
                .foregroundColor(.systemOrange)
            
            Spacer()
            
            BeforeAfterTotalStack(
                title: "after",
                split: "\((otbivka.opShareAfterReturn * 100).formattedGrouped)/\((otbivka.investorsShareAfterReturn * 100).formattedGrouped)",
                monthly: "\(otbivka.opDistributionPerMonthAfterReturn.threeSignificantDigits)/\(otbivka.investorsDistributionPerMonthAfterReturn.threeSignificantDigits)",
                yearly: "\(otbivka.opDistributionPerYearAfterReturn.smartNotation)/\(otbivka.investorsDistributionPerYearAfterReturn.smartNotation)",
                total: " ")
                .foregroundColor(.systemBlue)
            
            Spacer()
            
            BeforeAfterTotalStack(title: "total", split: " ", monthly: "\(otbivka.distributionPerMonth.threeSignificantDigits)", yearly: "\(otbivka.distributionPerYear.smartNotation)", total: "\(otbivka.opDistribution.smartNotation)/\(otbivka.investorsDistribution.smartNotation)")
                .foregroundColor(.systemBlue)
        }
    }
}

struct ROISplit4: View {
    var otbivka: Otbivka
    
    var body: some View {
        HStack {
            BeforeAfterTotalStackNEW(
                title: "distribution",
                monthly: "monthly".uppercased(),
                yearly: "yearly".uppercased(),
                isHeader: true)
                .foregroundColor(.secondary)
            
            Spacer()
            
            BeforeAfterTotalStackNEW(
                title: "before",
                monthly: "\(otbivka.opDistributionPerMonthBeforeReturn.threeSignificantDigits)/\(otbivka.investorsDistributionPerMonthBeforeReturn.threeSignificantDigits)",
                yearly: "\(otbivka.opDistributionPerYearBeforeReturn.smartNotation)/\(otbivka.investorsDistributionPerYearBeforeReturn.smartNotation)")
                .foregroundColor(.systemOrange)
            
            Spacer()
            
            BeforeAfterTotalStackNEW(
                title: "after",
                monthly: "\(otbivka.opDistributionPerMonthAfterReturn.threeSignificantDigits)/\(otbivka.investorsDistributionPerMonthAfterReturn.threeSignificantDigits)",
                yearly: "\(otbivka.opDistributionPerYearAfterReturn.smartNotation)/\(otbivka.investorsDistributionPerYearAfterReturn.smartNotation)")
                .foregroundColor(.systemBlue)
            
            Spacer()
            
            BeforeAfterTotalStackNEW(
                title: "total",
                monthly: "\(otbivka.distributionPerMonth.threeSignificantDigits)",
                yearly: "\(otbivka.distributionPerYear.smartNotation)")
                .foregroundColor(.systemBlue)
        }
    }
}

struct BeforeAfterTotalStack: View {
    var title: String
    var split: String
    var monthly: String
    var yearly: String
    var total: String
    var isHeader: Bool = false
    
    var alignment: HorizontalAlignment {
        if isHeader {
            return .leading
        } else {
            return .trailing
        }
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 3) {
            VStack(alignment: alignment, spacing: 0) {
                if #available(iOS 14.0, *) {
                    Text(title)//.uppercased())
                        .font(.caption2).foregroundColor(.systemTeal)
                } else {
                    // Fallback on earlier versions
                }
                if #available(iOS 14.0, *) {
                    Text(split).font(testingFont)
                } else {
                    // Fallback on earlier versions
                }
            }
            
            if #available(iOS 14.0, *) {
                Text(monthly).font(.caption2).foregroundColor(.secondary)
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 14.0, *) {
                Text(yearly).font(.caption2).foregroundColor(.secondary)
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 14.0, *) {
                Text(total).font(.caption2).foregroundColor(.secondary)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct BeforeAfterTotalStackNEW: View {
    var title: String
    var monthly: String
    var yearly: String
    var isHeader: Bool = false
    
    var alignment: HorizontalAlignment {
        if isHeader {
            return .leading
        } else {
            return .trailing
        }
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack(alignment: alignment, spacing: 3) {
                Text(title)
                    .foregroundColor(.systemTeal).opacity(0.6)
                Text(monthly)
                Text(yearly)
            }
            .font(.caption2).foregroundColor(.secondary)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ROISplit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROISplit2(otbivka: sampleROICollection.otbivki[0])
                    .environment(\.sizeCategory, .extraExtraLarge)
                ROISplit2(otbivka: sampleROICollection.otbivki[0])
                    .environment(\.sizeCategory, .extraExtraExtraLarge)
                ROISplit2(otbivka: sampleROICollection.otbivki[0])
                    .environment(\.sizeCategory, .accessibilityMedium)
                ROISplit2(otbivka: sampleROICollection.otbivki[0])
                    .environment(\.sizeCategory, .accessibilityLarge)
                ROISplit2(otbivka: sampleROICollection.otbivki[0])
                    .environment(\.sizeCategory, .accessibilityExtraLarge)
                ROISplit()
                    .environment(\.sizeCategory, .extraExtraLarge)
                ROISplit()
                    .environment(\.sizeCategory, .extraExtraExtraLarge)
                ROISplit()
                    .environment(\.sizeCategory, .accessibilityMedium)
                ROISplit()
                    .environment(\.sizeCategory, .accessibilityLarge)
                ROISplit()
                    .environment(\.sizeCategory, .accessibilityExtraLarge)
            }
            //            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}

