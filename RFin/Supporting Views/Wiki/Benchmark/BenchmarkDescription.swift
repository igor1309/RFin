//
//  BenchmarkDescription.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 07.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BenchmarkDescription: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var settings: SettingsStore
    
    @Binding var benchmark: Benchmark
    @State private var draft: Benchmark
    @State private var editMode = false
    
    init(benchmark: Binding<Benchmark>) {
        self._benchmark = benchmark
        self._draft = State(initialValue: benchmark.wrappedValue)
    }
    
    private func save() {
        //  MARK: TODO
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if editMode {
                    TextField("Benchmark Description", text: $draft.description)
                } else {
                    Text(self.draft.description)
                }
                Spacer()
            }
            .padding()
                
            .navigationBarTitle(benchmark.name)
                
            .navigationBarItems(
                leading: LeadingButtonSFSymbol(editMode ? "checkmark" : "pencil.and.ellipsis.rectangle") {
                    self.editMode.toggle()
                }
                .disabled(!settings.editingIsAllowed),
                
                trailing: TrailingButtonSFSymbol("xmark") {
                    self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct BenchmarkDescription_Previews: PreviewProvider {
    static var previews: some View {
        BenchmarkDescription(benchmark: .constant(sampleAnalytics.benchmarks[1]))
            .environment(\.colorScheme, .dark)
            .environmentObject(SettingsStore())
    }
}
