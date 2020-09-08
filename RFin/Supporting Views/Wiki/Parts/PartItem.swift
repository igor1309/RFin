//
//  PartItem.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 07.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PartItem: View {
    let locationColor: Color = .systemYellow
    let locationIcon = "rectangle.3.offgrid.fill"
    
    let positionColor: Color = .systemTeal
    let positionIcon = "person.fill"
    
    var part: Part
    
    var body: some View {
            Section(
                header: Text("\(part.abbreviation) - \(part.name)")
                    .font(.title3)
                    .foregroundColor(.primary),
                
                footer: ExpandableText(text: part.description)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 8, trailing: 0))) {
                
                NavigationLink(destination: EntryList(part: part.name, list: part.locations, name: "Locations", icon: self.locationIcon, color: self.locationColor)) {
                    HStack {
                        Image(systemName: self.locationIcon)
                            .frame(minWidth: 28, alignment: .center)
                        Text("Locations")
                    }
                }
                .foregroundColor(self.locationColor)
                
                NavigationLink(destination: EntryList(part: part.name, list: part.positions, name: "Positions", icon: self.positionIcon, color: self.positionColor)) {
                    HStack {
                        Image(systemName: self.positionIcon)
                            .frame(minWidth: 28, alignment: .center)
                        Text("Positions")
                    }
                }
                .foregroundColor(self.positionColor)
            }
    }
}

struct PartItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PartItem(part: sampleParts[0])
                PartItem(part: sampleParts[1])
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Parts")
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
