//
//  BenchmarkGroupSelector.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BenchmarkGroupSelector: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var benchmark: Benchmark
    
    @State private var groupToggles: Dictionary<BenchmarkGroup, Bool>
    
    init(benchmark: Binding<Benchmark>) {
        self._benchmark = benchmark
        
        var groupToggles: Dictionary<BenchmarkGroup, Bool> = [:]
        for group in BenchmarkGroup.allCases {
            let isIn: Bool = benchmark.wrappedValue.groups.contains(group)
            groupToggles.updateValue(isIn, forKey: group)
        }
        self._groupToggles = State(initialValue: groupToggles)
    }
    
    private func save() {
        // MARK: TODO
        var groups: [BenchmarkGroup] = []
        for (key,value) in groupToggles {
            if value {
                groups.append(key)
            }
        }
        
        benchmark.groups = groups
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Select groups"),
                    footer: Text("Benchmark could belong to multiple groups.")) {
                    
                    ForEach(BenchmarkGroup.allCases, id: \.self) { group in
                        
                        HStack {
                            Text(group.id)
                            if self.groupToggles[group] ?? false {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                        .foregroundColor(self.groupToggles[group] ?? false ? .primary : .secondary)
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                if self.groupToggles[group] != nil {
                                    if self.groupToggles[group]! {
                                        self.groupToggles.updateValue(false, forKey: group)
                                    } else {
                                        self.groupToggles.updateValue(true, forKey: group)
                                    }
                                } else {
                                    self.groupToggles.updateValue(true, forKey: group)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(benchmark.name)
            
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("xmark") {
                    self.presentation.wrappedValue.dismiss()
                }
                .foregroundColor(.systemRed),
                
                trailing: TrailingButtonSFSymbol("checkmark") {
                    self.save()
                    self.presentation.wrappedValue.dismiss()
                })
        }
    }
}

struct BenchmarkGroupSelector_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkGroupSelector(benchmark: .constant(sampleAnalytics.benchmarks[1]))
            .environment(\.colorScheme, .dark)
    }
}
