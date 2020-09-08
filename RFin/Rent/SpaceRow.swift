//
//  SpaceRow.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SpaceRow: View {
    @EnvironmentObject var userData: UserData
    var space: Space
    @State private var showModal = false
    
    var currencySymbol: String { userData.restaurant.currency.idd }
    
    var body: some View {
//        let currencySymbol = userData.restaurant.currency.idd
        var revenue: String
        var combo: String
        var fixed: String
        
        if userData.restaurant.currency == .rub {
            revenue = (space.expectedRevenue / 1_000_000).formattedGroupedWithDecimals + "m"
            combo = (space.comboRent / 1_000_000).formattedGroupedWithDecimals + "m"
            fixed = (space.fixedRent / 1_000_000).formattedGroupedWithDecimals + "m"
        } else {
            revenue = space.expectedRevenue.formattedGrouped
            combo = space.comboRent.formattedGrouped
            fixed = space.fixedRent.formattedGrouped
        }
        
        return VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(space.name)
                Spacer()
                Text("\(space.area1.formattedGrouped) + \(space.area2.formattedGrouped) sq m")
//                    .font(.callout)
            }
            .foregroundColor(.systemOrange)
            .font(.headline)
            
            VStack(spacing: 0) {
                if #available(iOS 14.0, *) {
                    HStack {
                        Text("revenue")
                            .frame(width: 90, alignment: .leading)
                            .foregroundColor(.systemGreen)
                        Text("revenue cut")
                            .foregroundColor(.systemTeal)
                        Spacer()
                        Group {
                            Text("combo rent")
                                .frame(width: 80, alignment: .leading)
                            Text("fixed rent")
                                .frame(width: 60, alignment: .leading)
                        }
                        .foregroundColor(.systemYellow)
                    }
                    .font(.caption2)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text(currencySymbol + revenue)
                        .frame(width: 90, alignment: .leading)
                        .foregroundColor(.systemGreen)
                    Text(space.revenueCut.smartFormatted)
                        .foregroundColor(.systemTeal)
                    
                    Spacer()
                    Group {
                        Text(currencySymbol + combo)
                            .frame(width: 80, alignment: .leading)
                        Text(currencySymbol + fixed)
                            .frame(width: 60, alignment: .leading)
                    }
                    .foregroundColor(.systemYellow)
                }
                .foregroundColor(.secondary)
                .font(.footnote)
            }
        }
        .padding(.vertical, 3)
        .contentShape(Rectangle())
        .onTapGesture {
            self.showModal = true
        }
            
        .contextMenu {
            Button(action: {
                self.duplicate(self.space)
            }) {
                HStack {
                    Text("Duplicate")
                    Image(systemName: "plus.square.on.square")
                }
            }
        }

        .sheet(isPresented: $showModal) {
            SpaceDetail(space: self.space)
                .environmentObject(self.userData)
        }
    }
    
    func duplicate(_ space: Space) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        withAnimation {
            self.userData.restaurant.place.add(self.space)
        }
    }
}

struct SpaceRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                SpaceRow(space: Space(sample: true))
            }
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
