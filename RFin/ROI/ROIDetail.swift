//
//  ROIDetail.swift
//  Rent
//
//  Created by Igor Malyarov on 04.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct ROIDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var otbivka: Otbivka
    @State var draft: Otbivka
    @State private var showRename = false
    @State private var showAlert = false
    
    init(otbivka: Otbivka) {
        self.otbivka = otbivka
        self._draft = State(initialValue: otbivka)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if showRename {
                        TextField("Return Name", text: $draft.name)
                    }
                    
                    Button(showRename ? "Done" : "Rename") {
                        self.showRename.toggle()
                    }
                }
                
                ROIDetailIRRSection(otbivka: $draft)
                
                ROIDetailInvestorSections(otbivka: $draft)
                
                ROIDetailFlowsSection(otbivka: draft)
            }
            .navigationBarTitle(draft.name)
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.save()
                self.presentation.wrappedValue.dismiss()
            })
                
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete \("Otbivka")?"),
                                message: Text("This operation couldn't be undone."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete otbivka")) {
                                        self.presentation.wrappedValue.dismiss()
                                        self.delete()
                                    }
                    ])
            }
        }
    }
    
    private func delete() {
        userData.roiCollection.delete(draft)
    }
    
    private func save() {
        if self.draft != self.otbivka {
            self.userData.roiCollection.update(self.otbivka, with: self.draft)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}

struct ROIDetail_Previews: PreviewProvider {
    static var previews: some View {
        ROIDetail(otbivka: sampleROICollection.otbivki[1])
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
