//
//  MainTabView.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        TabView(selection: $settings.selectedTab) {
            QuickPLList()
                .tabItem {
                    Label("Quick P&L", systemImage: "hare")
                }
                .tag(0)
            
            ROIList()
                .tabItem {
                    Label("ROI", systemImage: "chart.bar")
                }
                .tag(1)
            
            StaffVersionsView()
                //PayrollView(staff: userData.restaurant.staff)
                .tabItem {
                    Label("Payroll", systemImage: "person.2")
                }
                .tag(2)
            
            SpaceList()
                .tabItem {
                    Label("Rent", systemImage: "rectangle.grid.2x2")
                }
                .tag(3)
            
            WikiView()
                .tabItem {
                    Label("Wiki", systemImage: "book")
                }
                .tag(4)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
    }
}
