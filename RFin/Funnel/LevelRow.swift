//
//  LevelRow.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LevelRow: View {
    @Binding var funnel: Funnel
    var level: Level
    @State private var showAlert = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        LevelSubRow(funnel: $funnel, level: level)
            .onTapGesture {
                self.modal = .detail
                self.showModal = true }
            .contextMenu {
                Button(action: {
                    self.modal = .detail
                    self.showModal = true
                }) {
                    HStack {
                        Text("Show/Edit \("Level")")
                        Image(systemName: "aspectratio")
                    }
                }
                Button(action: {
                    self.duplicate(self.level)
                }) {
                    HStack {
                        Text("Duplicate \("Level")")
                        Image(systemName: "plus.square.on.square")
                    }
                }
                Button(action: {
                    self.showAlert = true
                }) {
                    HStack {
                        Text("Delete \("Level")")
                        Image(systemName: "trash.circle")
                    }
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete this \("Level?")".uppercased()),
                                message: Text("You can't undo this action."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete it")) { self.delete() } ])}}
            
            .sheet(isPresented: $showModal) {
                LevelDetail(funnel: self.$funnel, level: self.level, isNew: false) }
    }
    
    func duplicate(_ level: Level) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            funnel.duplicate(level)
        }
    }
    
    func delete() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        withAnimation {
            if funnel.delete(level) {
                generator.impactOccurred()
            }
        }
    }
}

struct LevelRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                LevelRow(funnel: .constant(sampleFunnels[0]),
                        level: sampleFunnels[0].levels[0])
            }
            .listStyle(GroupedListStyle())
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
