//
//  LevelSampleList.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct LevelSampleList: View {
    @Environment(\.presentationMode) var presentation
    @Binding var funnel: Funnel
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("Level")")) {
                    Button("Add all Sample \("Levels")") { self.showAction = true }
                }
                
                Section(header: Text("Sample Funnels".uppercased()),
                        footer: Text("Selected sample would be used to create a new entry to your Funnels.")) {
                            ForEach(sampleFunnels[0].levels, id: \.self) { level in
                                LevelSampleRow(funnel: self.$funnel,
                                              level: level)
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.addSelected(level: level) }
                            }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Sample")
                
            .navigationBarItems(leading: LeadingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
                
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("ADD ALL SAMPLES"),
                                message: Text("all samples confirmation"),
                                buttons: [
                                    .cancel(),
                                    .default(Text("Yes, add all samples")) {
                                        self.addAllSampleData() }])}
        }
    }
    
    func addAllSampleData() {
        if hapticsAvailable {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        funnel.addAllSampleData()
        presentation.wrappedValue.dismiss()
    }
    
    func addSelected(level: Level) {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        withAnimation {
            funnel.add(level)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct LevelSampleList_Previews: PreviewProvider {
    static var previews: some View {
        LevelSampleList(funnel: .constant(sampleFunnels[0]))
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
