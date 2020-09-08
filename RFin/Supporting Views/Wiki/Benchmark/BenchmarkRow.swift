//
//  BenchmarkRow.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 07.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct BenchmarkRow: View {
    @EnvironmentObject var settings: SettingsStore
    var benchmark: Benchmark
    @State private var draft: Benchmark
    
    init(benchmark: Benchmark) {
        self.benchmark = benchmark
        self._draft = State(initialValue: benchmark)
    }
    
    @State private var showModal = false
    @State private var modal: ModalType = .description
    
    private func save() {
        
        //  MARK: TODO
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(benchmark.name)
                    .foregroundColor(benchmark.isImportant ? .primary : .secondary)
                Spacer()
                Text(benchmark.value?.smartFormatted ?? "")
                    .foregroundColor(benchmark.isInRange ? .primary : .systemRed)
            }
            .font(.headline)
            
            HStack {
                HStack {
                    Text("Target")
                    Spacer()
                    
                    if benchmark.targetValue != nil {
                        Text("\(benchmark.targetValue!.smartFormatted)")
                    }
                    
                    if benchmark.targetRange != nil {
                        Text("[\(benchmark.targetRange!.lowerBound.smartFormatted) - \(benchmark.targetRange!.upperBound.smartFormatted)]")
                    }
                }
            }
            .foregroundColor(.systemTeal)
            .font(.subheadline)
            
            Text(benchmark.description)
                .lineLimit(1)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 3)
            
        .onTapGesture {
            self.modal = .description
            self.showModal = true
        }
            
        .contextMenu {
            Button(action: {
                self.modal = .editor
                self.showModal = true
            }) {
                HStack {
                    Text("Edit Benchmark")
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
            
        .sheet(isPresented: $showModal) {
            
            if self.modal == .description {
                BenchmarkDescription(benchmark: self.$draft)
                    .environmentObject(self.settings)
            }
            
            if self.modal == .editor {
                if self.settings.editingIsAllowed {
                    BenchmarkEditor(benchmark: self.benchmark)
                } else {
                    VStack {
                        Text("Editing is disabled")
                            .font(.headline)
                        HStack {
                            Text("You can change this in Settings")
                            Image(systemName: "gear")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct BenchmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                BenchmarkRow(benchmark: sampleAnalytics.benchmarks[1])
            }
        }
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}
