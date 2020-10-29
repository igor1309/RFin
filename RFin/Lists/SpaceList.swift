//
//  SpaceList.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct SpaceList: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var userData: UserData
    
    @State private var showModal = false
    @State private var modal: ModalType = .settings
    
    var isListEmpty: Bool { userData.restaurant.place.isListEmpty }
    
    var body: some View {
        List {
            if isListEmpty {
                Group {
                    Text("about Space").foregroundColor(.systemTeal)
                    Text("Tapping \("Space")").foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            
            Section(
                header: Text("\(isListEmpty ? "" : "Your list")"),
                footer: Text("\(isListEmpty ? "Tap + to add Space." : "When cards are open tap 'Done' to save changes. Swiping the card down to dismiss will ignore any changes.\nTapping + will generate new Space with random data.")")) {
                
                ForEach(userData.restaurant.place.spaces) { space in
                    SpaceRow(space: space)
                        .contentShape(Rectangle())
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Spaces")
        .navigationBarItems(leading: leading, trailing: trailing)
        .sheet(isPresented: $showModal) {
            if modal == .settings {
                SpaceSettings()
                    .environmentObject(userData)
            }
        }
    }
    
    @ViewBuilder
    var leading: some View {
        if sizeClass == .compact {
            LeadingButtonSFSymbol("gear") {
                modal = .settings
                showModal = true
            }
        }
    }
    
    @ViewBuilder
    var trailing: some View {
        HStack {
            EditButton()
            
            if sizeClass == .regular {
                TrailingButtonSFSymbol("gear") {
                    self.modal = .settings
                    self.showModal = true
                }
            }
            
            TrailingButtonSFSymbol("plus.app") { addSample() }
                .opacity(0.6)
            
            TrailingButtonSFSymbol("plus") { addNew() }
        }
    }
    
    func addNew() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.place.add(Space())
        }
    }
    
    func addSample() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.place.add(Space(sample: true))
        }
    }
    
    func delete(at offsets: IndexSet) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        withAnimation {
            userData.restaurant.place.spaces.remove(atOffsets: offsets)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        userData.restaurant.place.spaces.move(fromOffsets: source, toOffset: destination)
    }
}

struct SpaceList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpaceList()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
