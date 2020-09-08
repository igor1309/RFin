//
//  ROIRow.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

public struct CardModifier: ViewModifier {
    public var borderColor: Color = .systemGray
    public var cornerRadius: CGFloat = 8
    
    public func body(content: Content) -> some View {
        content
            .padding(12)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.primary.opacity(0.03))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke()
                    .opacity(0.2)
                    .foregroundColor(borderColor)
            )
    }
}

struct TableRow: View {
    var otbivka: Otbivka
    var isHeader = false
    var hasBackground = false
    
    var body: some View {
        
        if isHeader {
            //            return AnyView(
            return TableSubRow(isHeader: true)
            //                .background(hasBackground ? Color.secondarySystemFill : Color.tertiarySystemGroupedBackground)
            //            )
        } else {
            //            return AnyView(
            // VStack(alignment: .leading, spacing: 0) {
            return TableSubRow(
                horizon: otbivka.estimationPeriodInYears.formattedGroupedWithMax2Decimals + "y",
                irr: otbivka.irr?.formattedPercentageWith1Decimal ?? "n/a",
                profit: otbivka.investorsProfit.smartNotation,
                distribution: otbivka.opDistribution.smartNotation + "/" + otbivka.investorsDistribution.smartNotation,
                isHeader: false)
            
            //     Divider()
            
            //     ROISplit4(otbivka: otbivka)
            //     .offset(y: -2)
            //         .padding(.bottom, 8)
            // }
            //                .background(hasBackground ? Color.clear : Color.tertiarySystemGroupedBackground)
            //            )
        }
    }
}

struct TableSubRow: View {
    var horizon = "horizon"
    var irr = "IRR"
    var profit = "profit"
    var distribution = "distribution"
    var isHeader = false
    
    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
            GeometryReader { geo in
                HStack(spacing: 0) {
                    //                    Spacer()
                    
                    Text(self.horizon)
                        .foregroundColor(.primary)
                        .frame(width: geo.size.width / 6.5,
                               height: geo.size.height,
                               alignment: .leading)
                        .layoutPriority(1)
                    //                    .background(Color.primary.opacity(0.03))
                    
                    Spacer()
                    
                    Text(self.irr)
                        .foregroundColor(.systemYellow)
                        .frame(width: geo.size.width / 5,
                               height: geo.size.height,
                               alignment: self.isHeader ? .center : .trailing)
                    //                .background(Color.primary.opacity(0.03))
                    
                    Spacer()
                    
                    Text(self.profit)
                        .foregroundColor(.systemGreen)
                        .frame(width: geo.size.width / 5,
                               height: geo.size.height,
                               alignment: .trailing)
                    //                    .background(Color.primary.opacity(0.03))
                    
                    Spacer()
                    
                    Text(self.distribution)
                        .foregroundColor(.systemTeal)
                        .frame(width: geo.size.width / 3.5,
                               height: geo.size.height,
                               alignment: .trailing)
                    //                .background(Color.primary.opacity(0.03))
                    
                    //                    Spacer()
                }
                    .font(self.isHeader ? Font.caption2 : Font.subheadline)// title3)
            }
            .frame(height: isHeader ? 12 : 22)
            //            .border(Color.pink)
//        }
    }
}

struct ROINewSubRow: View {
    var otbivka: Otbivka
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Spacer()
                
                ElementWithTitle(
                    title: "investment",
                    valueAsString: otbivka.investment.smartNotation,
                    color: .systemOrange)
                
                Spacer()
                
                ElementWithTitle(
                    title: "before",
                    valueAsString: "\((otbivka.opShareBeforeReturn * 100).formattedGrouped)/\((otbivka.investorsShareBeforeReturn * 100).formattedGrouped)",
                    color: .systemTeal)
                
                Spacer()
                
                ElementWithTitle(
                    title: "after",
                    valueAsString: "\((otbivka.opShareAfterReturn * 100).formattedGrouped)/\((otbivka.investorsShareAfterReturn * 100).formattedGrouped)",
                    color: .systemBlue)
                
                Spacer()
            }
            
            Divider()
                
            HStack(spacing: 0) {
                Spacer()
                
                ElementWithTitle(
                    title: "return in",
                    valueAsString: otbivka.yearsToReturnInvestment.formattedGroupedWith1Decimal + "y",
                    color: .systemOrange)
                
                Spacer()
                
                ElementWithTitle(
                    title: "grace",
                    valueAsString: otbivka.gracePeriodInYears.formattedGroupedWith1Decimal + "y",
                    color: .secondary)
                
                Spacer()
            }
        }
    }
}

struct IRRCard: View {
    var otbivka: Otbivka
    
    var body: some View {
        
        var otbivka1 = otbivka
        otbivka1.estPeriodInMonths = otbivka.estPeriodInMonths - 12
        var otbivka2 = otbivka
        otbivka2.estPeriodInMonths = otbivka.estPeriodInMonths + 12
        
        return VStack(alignment: .leading, spacing: 8) {
            TableRow(otbivka: otbivka, isHeader: true)
            Divider()
            TableRow(otbivka: otbivka1)
            Divider()
            TableRow(otbivka: otbivka)
            Divider()
            TableRow(otbivka: otbivka2)
        }
        .modifier(CardModifier())
    }
}

struct ROIRow: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var otbivka: Otbivka
    @State private var showAlert = false
    @State private var showModal = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(otbivka.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                if otbivka.irr ?? 0 >= settings.irrThreshhold {
                    Spacer()
                    Image(systemName: "star.circle")
                }
            }
            .foregroundColor(.systemOrange)
            .padding(.vertical, 3)
            
            ROINewSubRow(otbivka: otbivka)
                .modifier(CardModifier())
                .onTapGesture { self.showModal = true }
            
            ROISplit4(otbivka: otbivka)
                .modifier(CardModifier())
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        IRRCard(otbivka: self.otbivka)
                            .frame(width: 320)
                    }
                }
            }
        }
        .padding(.bottom, 3)
        .contentShape(Rectangle())
            //        .onTapGesture { self.showModal = true }
            .contextMenu {
                Button(action: {
                    self.duplicate(self.otbivka)
                }) {
                    Text("Duplicate \("ROI")")
                    Image(systemName: "plus.square.on.square")
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    Text("Delete \("ROI")")
                    Image(systemName: "trash.circle")
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("ROI")?".uppercased()),
                                message: Text("can't delete"),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}
        }
            
        .sheet(isPresented: $showModal) {
            ROIDetail(otbivka: self.otbivka)
                .environmentObject(self.userData)
                .environmentObject(self.settings) }
    }
    
    func duplicate(_ otbivka: Otbivka) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.roiCollection.add(otbivka)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        withAnimation {
            userData.roiCollection.delete(otbivka)
        }
    }
}

struct ROIRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ROIRow(otbivka: sampleROICollection.otbivki[1])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
        //            .environment(\.sizeCategory, .extraExtraLarge)
    }
}
