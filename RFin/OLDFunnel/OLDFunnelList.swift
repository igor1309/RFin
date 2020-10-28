//
//  OLDFunnelList.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct OLDFunnelList: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        List {
            if userData.restaurant.channel.isListEmpty {
                Group {
                    Text("about Sales Funnel").foregroundColor(.systemTeal)
                    Text("Tapping \("Sales Funnel")").foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            
//            Section(header: Text("Direct array: Running")) {
//                ForEach(userData.restaurant.channel.funnels, id: \.self) { funnel in
//                    FunnelRow(funnel: funnel)
//                }
//            }
//
            Section(header: Text("Running")) {
                ForEach(userData.restaurant.channel.listRunning, id: \.self) { funnel in
                    OLDFunnelRow(funnel: funnel)
                }
            }
            
            Section(header: Text("Off")) {
                ForEach(userData.restaurant.channel.listOff, id: \.self) { funnel in
                    OLDFunnelRow(funnel: funnel)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Sales Funnels")
        .navigationBarItems(trailing:
            HStack {
                TrailingButtonSFSymbol("waveform.path.badge.plus") {
                    self.addRandom() }
                TrailingButtonSFSymbol("text.badge.plus") {
                    withAnimation {
                        self.addAllSampleData() }}})
    }
    
    func addRandom() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            self.userData.restaurant.channel.addRandom()
        }
    }
    
    func addAllSampleData() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        userData.restaurant.channel.addAllSampleData()
    }
    
    func addNew() {
        userData.restaurant.channel.add(sampleFunnels[0])
    }
}

struct OLDFunnelList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OLDFunnelList()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
