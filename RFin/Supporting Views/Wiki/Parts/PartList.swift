//
//  PartList.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 06.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PartList: View {
    @State private var isExpanded = false
    
    var body: some View {
        List {
            ForEach(sampleParts, id: \.self) { part in
                PartItem(part: part)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Parts")            
        .navigationBarItems(trailing: TrailingToggle(isOn: $isExpanded)) }
}

struct PartList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PartList()
            }
            
            PartList()
        }
        .environment(\.colorScheme, .dark)
    }
}
