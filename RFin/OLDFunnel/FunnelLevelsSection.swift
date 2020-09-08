//
//  FunnelLevelsSection.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FunnelLevelsSection: View {
    @EnvironmentObject var userData: UserData
    var currency: Currency { userData.restaurant.currency }
    @Binding var draft: Funnel
    
    var body: some View {
        Section(header: Text("Levels".uppercased())) {
            ForEach(draft.levels, id: \.self) { level in
                
                OLDLevelRow(funnel: self.$draft, level: level)
                
            }
//            .onMove(perform: move)
        }
    }
    
//    func move(from source: IndexSet, to destination: Int) {
//        userData.restaurant.channel.funnels.move(fromOffsets: source, toOffset: destination)
//    }
}

struct FunnelLevelsSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                FunnelLevelsSection(draft: .constant(sampleFunnels[0]))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
