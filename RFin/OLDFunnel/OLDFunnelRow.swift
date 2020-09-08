//
//  OLDFunnelRow.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct OLDFunnelRow: View {
    @EnvironmentObject var userData: UserData
    var funnel: Funnel
    @State private var showAlert = false
    @State private var showModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("name").foregroundColor(.secondary)
                Text(funnel.name).foregroundColor(.systemTeal)
                Spacer()
                Text("period \(funnel.period.id)")
            }
            
            Text(funnel.isRunning ? "ON" : "OFF")
            
            HStack {
                Text("conversion")
                Spacer()
                Text("\(funnel.conversion, specifier: "%.6f")")
            }
//            Text("traffic \(funnel.traffic.formattedGrouped)")
            Text("unitOfTraffic \(funnel.unitOfTraffic.formattedGrouped)")
            Text("pricePerUnitOfTrafic \(funnel.pricePerUnitOfTraffic.formattedGroupedWithMax2Decimals)")
//            Text("budget \(funnel.budget.formattedGrouped)")
//            Text("guests \(funnel.guests.formattedGrouped)")
//            Text("bottom \(funnel.bottom.formattedGrouped)")
//            Text("cps \(funnel.cps?.formattedGrouped ?? "n/a")")
        }
        .font(.subheadline)
        .contentShape(Rectangle())
        .onTapGesture { self.showModal = true }
        .contextMenu {
            Button(action: {
                self.toggleRunning(self.funnel)
            }) {
                HStack {
                    Text("\(funnel.isRunning ? "Deactivate" : "Activate") \("Funnel")")
                    Image(systemName: funnel.isRunning ? "xmark.circle" : "checkmark.circle")
                }
            }
            Button(action: {
                self.showAlert = true
            }) {
                HStack {
                    Text("Delete \("Funnel")")
                    Image(systemName: "trash.circle")
                }
            }
            .actionSheet(isPresented: $showAlert) {
                ActionSheet(title: Text("Delete this \("Funnel?")".uppercased()),
                            message: Text("You can't undo this action."),
                            buttons: [
                                .cancel(),
                                .destructive(Text("Yes, delete it")) { self.delete() } ])}}
            .sheet(isPresented: $showModal) {
                OLDFunnelDetail(funnel: self.funnel, isNew: false)
                    .environmentObject(UserData()) }
    }
    
    func toggleRunning(_ funnel: Funnel) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        //        withAnimation {
        if userData.restaurant.channel.toggleRunning(funnel) {
            generator.impactOccurred()
        }
        //        }
    }
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if userData.restaurant.channel.delete(funnel) {
                generator.impactOccurred()
            }
        }
    }
}

struct OLDFunnelRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                OLDFunnelRow(funnel: sampleFunnels[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
