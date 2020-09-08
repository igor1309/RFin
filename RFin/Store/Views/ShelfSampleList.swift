//
//  ShelfSampleList.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ShelfSampleList: View {
    @Environment(\.presentationMode) var presentation
    @Binding var storeWindow: StoreWindow
    @State private var showDetail = false
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("add all samples or select \("Shelf")")) {
                    Button("Add all Sample \("Shelfs")") { self.showAction = true }
                }
                
                Section(header: Text("Sample StoreWindows".uppercased()),
                        footer: Text("Selected sample would be used to create a new entry to your StoreWindows.")) {
                            ForEach(sampleStoreWindows[0].shelfs, id: \.self) { shelf in
                                ShelfSampleRow(storeWindow: self.$storeWindow,
                                              shelf: shelf)
                                    .contentShape(Rectangle())
                                    .onTapGesture { self.addSelected(shelf: shelf) }
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
        storeWindow.addAllSampleData()
        presentation.wrappedValue.dismiss()
    }
    
    func addSelected(shelf: Shelf) {
        if hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        withAnimation {
            storeWindow.add(shelf)
        }
        presentation.wrappedValue.dismiss()
    }
}

struct ShelfSampleList_Previews: PreviewProvider {
    static var previews: some View {
        ShelfSampleList(storeWindow: .constant(sampleStoreWindows[0]))
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
