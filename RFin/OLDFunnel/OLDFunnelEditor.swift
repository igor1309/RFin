//
//  OLDFunnelEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OLDFunnelEditor: View {
    @Binding var draft: Funnel

    var body: some View {
        Form {
            Section {
                TextFieldWithReset("Name", text: $draft.name)
                Toggle("Sales channel is running", isOn: $draft.isRunning)
            }
            
            FunnelTopSection(draft: $draft)
            
            FunnelBottomSection(draft: $draft)
            
            FunnelLevelsSection(draft: $draft)
        }
    }
}

struct OLDFunnelEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OLDFunnelEditor(draft: .constant(sampleFunnels[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
