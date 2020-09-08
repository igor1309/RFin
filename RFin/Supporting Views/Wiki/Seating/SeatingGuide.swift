//
//  SeatingGuide.swift
//  RFin
//
//  Created by Igor Malyarov on 13.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SeatingGuide: View {
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        
        let seatingAreaInSquareFeet = Measurement(value: settings.seatingGuideArea, unit: UnitArea.squareMeters).converted(to: UnitArea.squareFeet).value * (settings.isKitchenIncludedSeating ? 0.6 : 1.0)
        let seatingArea = settings.seatingGuideArea * (settings.isKitchenIncludedSeating ? 0.6 : 1.0)
        let kitchenArea = settings.seatingGuideArea * (settings.isKitchenIncludedSeating ? 0.4 : 0.4 / 0.6)
        
        return Form {
            Section(header: Text("Restaurant Area".uppercased()),
                    footer: VStack(alignment: .leading, spacing: 8) {
                        Text("Drag the slider to change Seating or Total area of the Restaurant.")
                            .lineLimit(3)
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Seating area")
                                    .frame(minWidth: 190, alignment: .leading)
                                Text(seatingArea.formattedGrouped)
                                .frame(minWidth: 50, alignment: .trailing)
                            }
                            HStack {
                                Text("+ (Kitchen & Extra Space)")
                                    .frame(minWidth: 190, alignment: .leading)
                                Text(kitchenArea.formattedGrouped)
                                .frame(minWidth: 50, alignment: .trailing)
                            }
                            HStack {
                                Text("= Total")
                                    .frame(minWidth: 190, alignment: .leading)
                                Text((seatingArea + kitchenArea).formattedGrouped)
                                .frame(minWidth: 50, alignment: .trailing)
                            }
                        }
                        .padding(.leading, 32)
            }) {
                
                Text("\(settings.isKitchenIncludedSeating ? "Total" : "Seating"): \(settings.seatingGuideArea.formattedGrouped) sq meters")
                
                Slider(value: $settings.seatingGuideArea,
                       in: 20.0...500.0,
                       step: 5,
                       minimumValueLabel: Image(systemName: "arrow.down.right.and.arrow.up.left")
                        .imageScale(.small)
                        .foregroundColor(.secondary),
                       maximumValueLabel: Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .imageScale(.small)
                        .foregroundColor(.secondary),
                       label: {
                        Text("\(settings.isKitchenIncludedSeating ? "Total" : "Seating"): \(settings.seatingGuideArea.formattedGrouped) sq m")
                })
                    .accentColor(Color.orange)
                    .onAppear {
                        if self.settings.seatingGuideArea == 0 {
                            self.settings.seatingGuideArea = 200
                        }
                }
                
                Toggle(isOn: $settings.isKitchenIncludedSeating) {
                    Text("Kitchen+ area (40%) is included")
                }
                
                //                VStack(alignment: .leading, spacing: 8) {
                //                    HStack {
                //                        Text("Seating area")
                //                            .frame(minWidth: 220, alignment: .leading)
                //                        Text(seatingArea.formattedGrouped)
                //                    }
                //                    HStack {
                //                        Text("+ (Kitchen & Extra Space)")
                //                            .frame(minWidth: 220, alignment: .leading)
                //                        Text(kitchenArea.formattedGrouped)
                //                    }
                //                    HStack {
                //                        Text("= Total")
                //                            .frame(minWidth: 220, alignment: .leading)
                //                        Text((seatingArea + kitchenArea).formattedGrouped)
                //                    }
                //                }
                //                .font(.subheadline)
                //                .foregroundColor(.secondary)
            }
            
            Section(header: Text("Number of Guests".uppercased())) {
                //  https://totalfood.com/how-to-create-a-restaurant-floor-plan/
                //  Fine Dining: 18 – 20 Square Feet
                //  Full Service Restaurant Dining: 12 – 15 Square Feet
                //  Counter Service: 18 – 20 Square Feet
                //  Fast Food Minimum: 11 – 14 Square Feet
                //  Table Service, Hotel/Club:  15 – 18 Square Feet
                //  Banquet, Minimum: 10 – 11 Square Feet
                
                //  MARK:- завести как данные!!
                HStack {
                    Text("Fine Dining")
                    Spacer()
                    Text("\((seatingAreaInSquareFeet / 20).formattedGrouped) - \((seatingAreaInSquareFeet / 18).formattedGrouped)")
                }
                .foregroundColor(.systemTeal)
                HStack {
                    Text("Full Service Restaurant")
                    Spacer()
                    Text("\((seatingAreaInSquareFeet / 15).formattedGrouped) - \((seatingAreaInSquareFeet / 12).formattedGrouped)")
                }
                .foregroundColor(.systemYellow)
                HStack {
                    Text("Counter Service")
                    Spacer()
                    Text("\((seatingAreaInSquareFeet / 20).formattedGrouped) - \((seatingAreaInSquareFeet / 18).formattedGrouped)")
                }
                .foregroundColor(.secondary)
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Fast Food, Maximum")
                        //                            Text("Maximum")
                        //                                .foregroundColor(.secondary)
                        //                                .font(.subheadline)
                    }
                    Spacer()
                    Text("\((seatingAreaInSquareFeet / 14).formattedGrouped) - \((seatingAreaInSquareFeet / 11).formattedGrouped)")
                }
                .foregroundColor(.secondary)
                HStack {
                    Text("Table Service, Hotel/Club")
                    Spacer()
                    Text("\((seatingAreaInSquareFeet / 18).formattedGrouped) - \((seatingAreaInSquareFeet / 15).formattedGrouped)")
                }
                .foregroundColor(.secondary)
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Banquet, Maximum")
                        //                            Text("Maximum")
                        //                                .foregroundColor(.secondary)
                        //                                .font(.subheadline)
                    }
                    Spacer()
                    Text("\((seatingAreaInSquareFeet / 11).formattedGrouped) - \((seatingAreaInSquareFeet / 10).formattedGrouped)")
                }
                .foregroundColor(.secondary)
            }
            
            Section(header: Text("Notes".uppercased())) {
                //TODO: - надо бы текст переписать (копирайт!!)
                Text("For safety reasons and to allow for the free flow of traffic for diners and servers, the traffic path between occupied chairs should be at least 50 centimeters wide and you should leave at least 120 – 150 centimeters per table, including chair space. This allows for free movement of servers between stations and the kitchen and provides enough comfortable room for the guests to move around. It is very important for safety reasons that there is enough space for the guest and staff to move around and that the aisles are clear, especially in case there is a fire.").italic()
                    .font(.caption)
                    .lineLimit(nil)
                    .foregroundColor(Color.secondary)
            }
        }
        .navigationTitle("Seating Guidelines")
    }
}

struct SeatingGuide_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SeatingGuide()
        }
        .environment(\.sizeCategory, .extraLarge)
        .environment(\.colorScheme, .dark)
        .environmentObject(SettingsStore())
    }
}
