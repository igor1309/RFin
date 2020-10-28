//
//  BenchmarkList.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 07.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BenchmarkList: View {
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showModal = false
    
    var body: some View {
        VStack {
            Picker(selection: $settings.selectedBenchmarkFilter,
                   label: Text("Select Benchmark Importance")) {
                Text("all").tag(0)
                Text("important").tag(1)
                Text("other").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
            .padding(.horizontal)
            
            List {
                ForEach(BenchmarkGroup.allCases, id: \.self) { group in
                    
                    Section(header: Text(group.id)) {
                        
                        ForEach(sampleAnalytics.benchmarks
                                    .filter({
                                        
                                        switch self.settings.selectedBenchmarkFilter {
                                            case 1: return $0.groups.contains(group) && $0.isImportant
                                            case 2: return $0.groups.contains(group) && !$0.isImportant
                                            default: return $0.groups.contains(group)
                                        }
                                        
                                    }), id: \.self) { benchmark in
                            
                            BenchmarkRow(benchmark: benchmark)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Benchmarks")
            .navigationBarItems(trailing: TrailingButtonSFSymbol("gear") {
                self.showModal = true
            })
            .sheet(isPresented: $showModal) {
                BenchmarkSettings()
                    .environmentObject(self.settings)
            }
        }
    }
}

struct BenchmarkList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                BenchmarkList()
            }
            
            BenchmarkList()
        }
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}
