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

    var body: some View {
        Section(
            header: Text("Benchmarks")
        ) {
            ListRowWithSheet(icon: "scope", title: "Benchmarks", subtitle: "Industry standarts and best practices.", color: .systemTeal) {
                NavigationView {
                    BenchmarkList()
                        .environmentObject(self.settings)
                }
            }
        }
        
        Section(
            header: Text("Seating")
        ) {
            ListRowWithSheet(icon: "square.grid.4x3.fill", title: "Seating Guidelines", subtitle: "With calculations.", color: .systemOrange) {
                NavigationView {
                    SeatingGuide()
                }
            }
        }
        
        Section(
            header: Text("Topics")
        ) {
            ListRowWithSheet(icon: "text.append", title: "Business Plan", subtitle: "How to Write a Restaurant Business Plan.", color: .systemPurple) {
                NavigationView {
                    BusinessPlanList()
                        .environmentObject(self.settings)
                }
            }
            
            ListRowWithSheet(icon: "rectangle.3.offgrid", title: "Restaurant Parts", subtitle: "Locations and Staff (positions).", color: .systemYellow) {
                NavigationView {
                    PartList()
                }
            }
        }
        
        Section(
            header: Text("Testing")
        ) {
            ListRowWithSheet(icon: "line.horizontal.3.decrease", title: "Sales Funnels", subtitle: "a work in progress…", color: .systemTeal) {
                FunnelSampleList()
                    .environmentObject(self.userData)
            }
            
            ListRowWithSheet(icon: "line.horizontal.3.decrease", title: "Sales Funnels", subtitle: "a work in progress…", color: .systemTeal) {
                NavigationView {
                    FunnelList()
                }
            }
        }
        
        Section(
            header: Text("Pattern with Protocol")
        ) {
            ListRowWithSheet(icon: "studentdesk", title: "Store with StoreWindows", subtitle: "A Sample for List Structures.", color: .systemPurple) {
                NavigationView {
                    StoreWindowList()
                        .environmentObject(self.userData)
                }
            }
        }
        
        Section(
            header: Text("Pattern")
        ) {
            ListRowWithSheet(icon: "studentdesk", title: "Network with Connections", subtitle: "A Sample for List Structures.", color: .systemGreen) {
                NavigationView {
                    ConnectionList()
                }
            }
        }
    }
}

struct WikiSections_Previews: PreviewProvider {
    static var previews: some View {
        WikiSections()
    }
}
