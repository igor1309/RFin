//
//  StaffVersionsView.swift
//  RFin
//
//  Created by Igor Malyarov on 11.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI
import CoreHaptics

struct StaffVersionsView: View {
    @EnvironmentObject var userData: UserData
    var hapticsAvailable: Bool { CHHapticEngine.capabilitiesForHardware().supportsHaptics }
    
    var body: some View {
        NavigationView {
            List {
                Text("TBD: sort by date modified").font(.subheadline).foregroundColor(.systemRed)
                
                ForEach(userData.restaurant.staffVersions.versions, id: \.self) { staff in
                    
                    StaffVersionRow(staff: staff)
                }
            }
            .navigationBarTitle("Staff Versions")
            .navigationBarItems(
                trailing: HStack {
                    TrailingButtonSFSymbol("plus.app") {
                        self.addSample()
                    }
                    
                    TrailingButtonSFSymbol("plus") {
                        self.addEmpty()
                    }
            })
        }
    }
    
    func addEmpty() {
        userData.restaurant.staffVersions.addEmpty()
        
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    func addSample() {
        self.userData.restaurant.staffVersions.addSample()
        
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}

struct StaffVersionsPreviews: PreviewProvider {
    static var previews: some View {
        StaffVersionsView()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
