//
//  ROIList.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ROIList: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showModal = false
    @State private var modal: ModalType = .settings
    
    var isListEmpty: Bool { userData.roiCollection.otbivki.isEmpty }
    
    var body: some View {
        List {
            if isListEmpty {
                Group {
                    Text("about ROI").foregroundColor(.systemTeal)
                    Text("Tapping \("ROI")").foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            
            //                Text(isListEmpty ? "Tapping \("ROI")" : "ModelIRR")
            //                    .font(.footnote)
            //                    .foregroundColor(.secondary)
            
            Section(
                header: Text("\(isListEmpty ? "" : "Your list")")
            ) {
                
                ForEach(userData.roiCollection.otbivki) { otbivka in
                    ROIRow(otbivka: otbivka)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            
            Section(
                footer: Text(isListEmpty ? "" : "ModelIRR").foregroundColor(.secondary).lineLimit(nil)
            ) {
                EmptyView()
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("ROIs")
        .navigationBarItems(leading: leading, trailing: trailing)
        .sheet(isPresented: $showModal) {
            if self.modal == .samples {
                ROIOptions()
                    .environmentObject(self.settings)
                    .environmentObject(self.userData)
            }
            
            if self.modal == .settings {
                ROISettings()
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
                
            }
        }
    }
    
    @ViewBuilder
    var leading: some View {
        if sizeClass == .compact {
            LeadingButtonSFSymbol("gear") {
                self.modal = .settings
                self.showModal = true
            }
        }
    }
    
    @ViewBuilder
    var trailing: some View {
        HStack {
            if sizeClass == .regular {
                TrailingButtonSFSymbol("gear") {
                    self.modal = .settings
                    self.showModal = true
                }
            }
            TrailingButtonSFSymbol("waveform.path.badge.plus") {
                self.addRandom()
            }
            TrailingButtonSFSymbol("text.badge.plus") {
                withAnimation {
                    self.modal = .samples
                    self.showModal = true
                }
            }
        }
    }
    
    func addRandom() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            self.userData.roiCollection.addRandom()
        }
    }
    
    func delete(at offsets: IndexSet) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        withAnimation {
            userData.roiCollection.otbivki.remove(atOffsets: offsets)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        userData.roiCollection.otbivki.move(fromOffsets: source, toOffset: destination)
    }
}

struct ROIList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ROIList()
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
