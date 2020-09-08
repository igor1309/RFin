//
//  SpaceSettings.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 12.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct SpaceSettings: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @State private var showAction = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("RESET"),
                        footer: Text("can delete all \("Spaces")")) {
                            Button("Delete all") {
                                self.showAction = true
                            }
                            .foregroundColor(userData.restaurant.place.spaces.isEmpty ? .secondary : .systemRed)
                            .disabled(userData.restaurant.place.spaces.isEmpty)
                            .actionSheet(isPresented: $showAction) {
                                ActionSheet(title: Text("Delete all?".uppercased()),
                                            message: Text("Are you 100% sure you want to delete all rows?\nYou can't undo this action."), buttons: [
                                                .cancel(),
                                                .destructive(Text("Yes, delete all")) {
                                                    self.deleteAll()
                                                    self.presentation.wrappedValue.dismiss()
                                                }])}
                }
            }
            .navigationBarTitle("Settings")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss() })
        }
    }
    
    func deleteAll() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        withAnimation {
            userData.restaurant.place.reset()
        }
    }
    
}

struct SpaceSettings_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettings()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}
