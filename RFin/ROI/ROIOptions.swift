//
//  ROIOptions.swift
//  RFin
//
//  Created by Igor Malyarov on 14.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ROIOptions: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    //    @EnvironmentObject var settings: SettingsStore
    
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("ROI")")) {
                    Button("Add all Samples \("ROI")") { self.showAction = true }
                }
                
                ForEach(sampleROICollection.otbivki.map { $0.investment }.removingDuplicates(), id: \.self) { investment in
                    
                    Section(header: Text(investment.smartNotation.uppercased())) {
                        
                        ForEach(sampleROICollection.otbivki
                            .filter { $0.investment == investment }
                        , id: \.self) { otbivka in
                            
                            VStack(alignment: .leading, spacing: 3) {
                                ROISubRowHeader(otbivka: otbivka)
                                ROISubRowMainPart(otbivka: otbivka)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.addSelected(otbivka: otbivka)
                                self.presentation.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Sample")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
                
                .actionSheet(isPresented: $showAction) {
                    ActionSheet(title: Text("ADD ALL SAMPLES"), message: Text("all samples confirmation"), buttons: [
                        .cancel(),
                        .default(Text("Yes, add all samples")) {
                            self.addAllSampleData() }])}
        }
    }
    
    func addAllSampleData() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        userData.roiCollection.addAllSampleData()
        self.presentation.wrappedValue.dismiss()
    }
    
    func addSelected(otbivka: Otbivka) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        withAnimation {
            userData.roiCollection.add(otbivka)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct ROIOptions_Previews: PreviewProvider {
    static var previews: some View {
        ROIOptions()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
