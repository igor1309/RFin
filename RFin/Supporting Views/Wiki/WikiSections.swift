//
//  WikiSections.swift
//  RFin
//
//  Created by Igor Malyarov on 08.09.2020.
//

import SwiftUI

struct WikiSections: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    let sizeClass: UserInterfaceSizeClass
    
    var body: some View {
        Section(
            header: Text("Benchmarks")
        ) {
            ListRowWithSheet(sizeClass: sizeClass, icon: "scope", title: "Benchmarks", subtitle: "Industry standarts and best practices.", color: .systemTeal) {
                BenchmarkList()
                    .environmentObject(self.settings)
            }
        }
        
        Section(
            header: Text("Seating")
        ) {
            ListRowWithSheet(sizeClass: sizeClass, icon: "square.grid.4x3.fill", title: "Seating Guidelines", subtitle: "With calculations.", color: .systemOrange) {
                SeatingGuide()
            }
        }
        
        Section(
            header: Text("Wiki")
        ) {
            ListRowWithSheet(sizeClass: sizeClass, icon: "text.append", title: "Business Plan", subtitle: "How to Write a Restaurant Business Plan.", color: .systemPurple) {
                BusinessPlanList()
                    .environmentObject(self.settings)
            }
            
            ListRowWithSheet(sizeClass: sizeClass, icon: "rectangle.3.offgrid", title: "Restaurant Parts", subtitle: "Locations and Staff (positions).", color: .systemYellow) {
                PartList()
            }
        }
        
        Section(
            header: Text("Performance Marketing")
        ) {
            ListRowWithSheet(sizeClass: sizeClass, icon: "line.horizontal.3.decrease", title: "Sales Funnels", subtitle: "a work in progress…", color: .systemTeal) {
                NavigationView {
                    FunnelList()
                }
            }
            
            ListRowWithSheet(sizeClass: sizeClass, icon: "line.horizontal.3.decrease", title: "Sales Funnels", subtitle: "a work in progress…", color: .systemTeal) {
                FunnelSampleList()
                    .environmentObject(self.userData)
            }
        }
        
        Section(
            header: Text("Testing")
        ) {
            ListRowWithSheet(sizeClass: sizeClass, icon: "studentdesk", title: "Store with StoreWindows", subtitle: "A Sample for List Structures.", color: .systemPurple) {
                NavigationView {
                    StoreWindowList()
                        .environmentObject(self.userData)
                }
            }
            ListRowWithSheet(sizeClass: sizeClass, icon: "studentdesk", title: "Network with Connections", subtitle: "A Sample for List Structures.", color: .systemGreen) {
                NavigationView {
                    ConnectionList()
                }
            }
        }
    }
}

struct WikiSections_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                WikiSections(sizeClass: .compact)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .preferredColorScheme(.dark)
    }
}
