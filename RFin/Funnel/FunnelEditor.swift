//
//  FunnelEditor.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelEditor: View {
    @Binding var draft: Funnel
    
    var body: some View {
        Form {
            Section(header: Text("Funnel Details"),
                    footer: Text("")) {
                        
                        TextFieldWithReset("Name", text: $draft.name)
                        TextFieldWithReset("Description", text: $draft.description)
                        
                        CustomToggle(title: "Funnel Status", isOn: $draft.isRunning)
            }
            
            FunnelTopSection(draft: $draft)
            
            FunnelBottomSection(draft: $draft)
            
            if !draft.levels.isEmpty {
                Section(header: Text("Levels"), footer: Text("Some Footer.")) {
                    ForEach(draft.levels, id: \.self) { level in
                        LevelRow(funnel: self.$draft, level: level)
                    }
                }
            }
        }
    }
}

struct FunnelEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FunnelEditor(draft: .constant(sampleFunnels[0]))
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
