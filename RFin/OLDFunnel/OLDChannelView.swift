//
//  OLDChannelView.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OLDChannelView: View {
    var body: some View {
        NavigationView {
            OLDFunnelList()
        }
    }
}

struct OLDChannelView_Previews: PreviewProvider {
    static var previews: some View {
        OLDChannelView()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
