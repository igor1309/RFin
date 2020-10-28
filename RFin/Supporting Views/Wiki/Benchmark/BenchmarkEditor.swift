//
//  BenchmarkEditor.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 07.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BenchmarkEditor: View {
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var settings: SettingsStore
    
    var benchmark: Benchmark
    
    @State private var draft: Benchmark
    @State private var showModal = false
    @State private var modal:  ModalType = .groups
        
    init(benchmark: Benchmark) {
        self.benchmark = benchmark
        self._draft = State(initialValue: benchmark)
    }
    
    private func save() {
        // MARK: TODO
    }
    
    private func delete() {
        // MARK: TODO
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Benchmark")) {
                    TextField("Benchmark Name", text: $draft.name)
                    Toggle("Is Important", isOn: $draft.isImportant)
                }
                
                Section(header: Text("Groups"),
                        footer: Text("footer")) {
                            
                            Button(stringFromArray(draft.groups.map{ $0.id })) {
                                self.modal = .groups
                                self.showModal = true
                            }
                }
                
                Section(header: Text("Target"),
                        footer: Text("footer")) {
                            Text("Target Range and Value TO BE DONE").foregroundColor(.systemRed)
                }
                
                Section(header: Text("Description")) {
                    // MARK: TODO нужен mulityline TextField
                    Text(draft.description)
                        .onTapGesture {
                            self.modal = .description
                            self.showModal = true
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
                }
            )
                
                .sheet(isPresented: $showModal) {
                    if self.modal == .groups {
                        BenchmarkGroupSelector(benchmark: self.$draft)
                    }
                    
                    if self.modal == .description {
                        BenchmarkDescription(benchmark: self.$draft)
                            .environmentObject(self.settings)
                    }
            }
        }
    }
}

struct BenchmarkEditor_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkEditor(benchmark: sampleAnalytics.benchmarks[1])
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
    }
}
