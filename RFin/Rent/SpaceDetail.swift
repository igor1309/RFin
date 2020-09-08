//
//  SpaceDetail.swift
//  Rent
//
//  Created by Igor Malyarov on 04.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct SpaceDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var space: Space
    
    @State var draft: Space
    @State private var showRename = false
    @State private var showAlert = false
    
    init(space: Space) {
        self.space = space
        self._draft = State(initialValue: space)
    }
    
    var body: some View {
        NavigationView {
            Form {
                if showRename {
                    TextField("Place Name", text: $draft.name)
                }
                
                Button(showRename ? "Done" : "Rename") {
                    showRename.toggle()
                }
                
                RentComparisonSection(space: $draft)
                
                RevenueSection(space: $draft)
                
                FixedRentRateSection(space: $draft)
                
                ComboRentRateSection(space: $draft)
            }
            .navigationTitle(draft.name)
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.saveAndDismiss()
            })
            .actionSheet(isPresented: $showAlert, content: deleteAction)
        }
    }
    
    private func deleteAction() -> ActionSheet {
        ActionSheet(
            title: Text("Delete Space?"),
            message: Text("This operation couldn't be undone."),
            buttons: [
                .cancel(),
                .destructive(Text("Yes, delete space")) {
                    self.presentation.wrappedValue.dismiss()
                    self.delete()
                }
            ]
        )
    }
    
    private func delete() {
        userData.restaurant.place.delete(draft)
    }
    
    private func saveAndDismiss() {
        if draft != space {
            let generator = UINotificationFeedbackGenerator()
            if userData.restaurant.place.update(space, with: draft) {
                generator.notificationOccurred(.success)
            } else {
                generator.notificationOccurred(.error)
            }
        }
        presentation.wrappedValue.dismiss()
    }
}

struct SpaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        SpaceDetail(space: Space(sample: true))
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
        
    }
}
