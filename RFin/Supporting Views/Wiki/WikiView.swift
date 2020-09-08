//
//  WikiView.swift
//  RFin
//
//  Created by Igor Malyarov on 12.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct WikiView: View {
    var body: some View {
        List {
            WikiSections()
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Wiki")
    }
}

struct WikiView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WikiView()
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .large)
        .previewLayout(.fixed(width: 343, height: 1000))
    }
}
