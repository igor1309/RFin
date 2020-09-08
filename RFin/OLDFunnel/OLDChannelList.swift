//
//  OLDChannelList.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct OLDFunnelNewDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    var funnel: Funnel
    @State private var draft: Funnel
    
    init(funnel: Funnel) {
        self.funnel = funnel
        self._draft = State(initialValue: funnel)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextFieldWithReset("Funnel Name", text: $draft.name)
            }
            .navigationBarTitle(draft.name)
            .navigationBarItems(trailing: HStack {
                TrailingButtonSFSymbol("checkmark") {
                    self.saveAndDismiss()
                }
            })
        }
    }
    
    private func saveAndDismiss() {
        if draft != funnel {
            let generator = UINotificationFeedbackGenerator()
            if userData.restaurant.channel.update(funnel, with: draft) {
                generator.notificationOccurred(.success)
            } else {
                generator.notificationOccurred(.error)
            }
        }
        presentation.wrappedValue.dismiss()
    }
}

struct OLDFunnelNewRow : View {
    @EnvironmentObject var userData: UserData
    var funnel: Funnel
    @State private var showModal = false
    
    var body: some View {
        HStack {
            Text(funnel.name)
            Spacer()
            Text(funnel.traffic.formattedGrouped)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.showModal = true
        }
        .sheet(isPresented: $showModal) {
            OLDFunnelNewDetail(funnel: self.funnel)
                .environmentObject(UserData())
        }
    }
}

struct OLDChannelList: View {
    @EnvironmentObject var userData: UserData
    
    var channel: Channel { userData.restaurant.channel }
    var isListEmpty: Bool { userData.restaurant.place.isListEmpty }

    var body: some View {
        NavigationView {
            List {
                if isListEmpty {
                    Group {
                        Text("about Channel").foregroundColor(.systemTeal)
                        Text("Tapping \("Sales Funnel")").foregroundColor(.secondary)
                    }
                    .font(.footnote)
                }
                
                ForEach(channel.funnels) { funnel in
                    OLDFunnelNewRow(funnel: funnel)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Channel: Funnels")
            .navigationBarItems(trailing: HStack {
                TrailingButtonSFSymbol("plus") {
                    //  add element here
                }
            })
        }
    }
}

struct OLDChannelList_Previews: PreviewProvider {
    static var previews: some View {
        OLDChannelList()
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
