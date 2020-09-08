//
//  ExpandableText.swift
//  RFin
//
//  Created by Igor Malyarov on 15.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ExpandableText: View {
    var text: String
    var maxLength: Int = 120
    @State private var isExpanded: Bool = false
    
    var body: some View {
        Group {
            Text(isExpanded ? text : String(text.prefix(maxLength)) + "…")
                + Text(isExpanded ? "" : " more")
                    .italic()
                    .foregroundColor(.systemBlue)
        }
        .onTapGesture {
            self.isExpanded.toggle() }
    }
}

struct More_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ExpandableText(text: "kdfj h;afhgo hodfh gof;ohg ;fhd ;gha sdf gshdf fhd dfh sdfh sdh vsdfh vfohfdohv sodfh vsodfuhv sodhv sdofhb sdfohfb soihosidh boisdfh b;soifdhb so;ihf sd ofdhbi hb sohb soihbsob hsfogb soh")
            }
        }
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
