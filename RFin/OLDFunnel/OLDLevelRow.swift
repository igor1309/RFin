//
//  OLDLevelRow.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OLDLevelRow: View {
    @EnvironmentObject var userData: UserData
    @Binding var funnel: Funnel
    var level: Level
    @State private var showModal = false
    
    var body: some View {
        ListRow2(title: level.name,
                 subtitle: level.description,
                 detail: level.conversionRate.formattedPercentageWithDecimals,
                 full: true)
            .contentShape(Rectangle())
            .onTapGesture { self.showModal = true }
            .contextMenu {
                Button(action: {
                    //  MARK: TODO
                }) {
                    HStack {
                        Text("Delete \("Level")")
                        Image(systemName: "trash.circle")
                    }
                }
        }
        .sheet(isPresented: $showModal) {
            OLDLevelDetail(funnel: self.$funnel, level: self.level)
                .environmentObject(self.userData) }
    }
    
    func duplicate(_ level: Level) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        //        withAnimation {
        //            userData.restaurant.channel.add(level)
        //        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        //        withAnimation {
        //            userData.restaurant.channel.delete(level)
        //        }
    }
}

struct OLDLevelRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(sampleFunnels[0].levels, id: \.self) { level in
                OLDLevelRow(funnel: .constant(sampleFunnels[0]), level: level)
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
