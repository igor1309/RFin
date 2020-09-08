//
//  EntryList.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 06.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EntryList: View {
    var part: String
    var list: [Entry]
    var name: String
    var icon: String
    var color: Color = .systemTeal
    
    var body: some View {
        List {
            Section(header: Text(name.uppercased())) {
                ForEach(list) { entry in
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: self.icon)
                            .foregroundColor(self.color)
                            .imageScale(.small)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.name)
                                .font(.headline)
                                .foregroundColor(self.color)
                            Text(entry.description)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(.bottom, 8)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
            
        .navigationBarTitle(part)
    }
}

struct EntryList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EntryList(part: "Front of House",
                      list: sampleParts[1].locations,
                      name: "Locations",
                      icon: "person")
                .environment(\.colorScheme, .dark)
        }
    }
}
