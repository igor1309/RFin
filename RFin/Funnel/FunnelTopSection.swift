//
//  FunnelTopSection.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelTopSection: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    @Binding var draft: Funnel
    
    let footer =
        Text("Traffic").foregroundColor(.primary)
            + Text(" is a total number of impressions (views) for a given period, top level of the Funnel.")
            + Text("\nCPM").foregroundColor(.primary)
            + Text(" (Cost per mille/thousand) is a price for every 1,000 impressions (views) of a particular advertisement.")
            + Text("\nCPI").foregroundColor(.primary)
            + Text(" (Cost per impression) is a price for a number of impressions (views).")
            + Text("\nHold for context menu.").italic()
    
    var body: some View {
        Section(header: Text("Top (per \(draft.period.id))"),
                footer: footer) {
                    Group {
                        Stepper(value: $draft.traffic, step: 5_000) {
                            ImageRow(image: "person.crop.square",
                                     title: "Traffic",
                                     detail: draft.traffic.formattedGrouped,
                                     isHighlighted: true)
                        }
                        .contextMenu {
                            ForEach(3 ..< 8) { item in
                                Button(action: {
                                    self.draft.traffic = pow(10, Double(item))
                                }) {
                                    HStack {
                                        Text(pow(10, Double(item)).formattedGrouped)
                                        Image(systemName: "arrowshape.turn.up.left")
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            Text("per")
                            Picker(selection: $draft.period, label: Text("Period")) {
                                ForEach(Period.allCases, id: \.id) { period in
                                    Text(period.rawValue).tag(period)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Stepper(value: $draft.pricePerUnitOfTraffic, step: currency == .rub ? 50 : 0.5) {
                            ImageRow(image: "dial",
                                     title: draft.unitOfTraffic == 1_000 ? "CPM" : "CPI",
                                     detail:  currency.idd + draft.pricePerUnitOfTraffic.smartNotation,
                                     isHighlighted: true)
                        }
                        .contextMenu {
                            ForEach(0..<funnelSlices.count) { index in
                                Button(action: {
                                    self.draft.unitOfTraffic = 1_000
                                    self.draft.period = funnelSlices[index].period
                                    if self.currency == .rub {
                                        self.draft.pricePerUnitOfTraffic = ((funnelSlices[index].price * 70) / 100).rounded(.up) * 100
                                    } else {
                                        self.draft.pricePerUnitOfTraffic = funnelSlices[index].price
                                    }
                                }) {
                                    HStack {
                                        Text(funnelSlices[index].name)
                                        Image(systemName: "arrowshape.turn.up.left")
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            Text("per")
                            Picker(selection: $draft.unitOfTraffic, label: Text("Unit of Traffic")) {
                                ForEach(1...4, id: \.self) { item in
                                    Text(pow(10, Double(item)).formattedGrouped)
                                        .tag(pow(10, Double(item)))
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            Image(systemName: "person.crop.square")
                        }
                    }
        }
    }
}

struct FunnelTopSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                FunnelTopSection(draft: .constant(sampleFunnels[0]))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
