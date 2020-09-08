//
//  PayrollView.swift
//  Payroll
//
//  Created by Igor Malyarov on 02.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PayrollView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @Binding var staff: Staff
    @State private var showModal = false
    @State private var modal: ModalType = .add
    
    var body: some View {
        NavigationView {
            VStack {
                StaffSummary(staff: staff)
                    .padding(.horizontal)
                
                PayrollGroupingPicker()
                    .padding(.horizontal)
                
                PayrollList(staff: $staff)
            }
            .navigationBarTitle(staff.name)
                
            .navigationBarItems(
                leading: LeadingButtonSFSymbol("gear") {
                    self.modal = .settings
                    self.showModal = true },
                trailing: TrailingButtonSFSymbol("text.badge.plus") {
                    self.modal = .add
                    self.showModal = true }
            )
                .sheet(isPresented: $showModal) {
                    if self.modal == .add {
                        NewPosition(staff: self.$staff)
                            .environmentObject(self.userData)
                    }
                    
                    if self.modal == .settings {
                        PayrollSettings(staff: self.$staff)
                            .environmentObject(self.userData) }
            }
        }
    }
}

struct PayrollView_Previews: PreviewProvider {
    static var previews: some View {
        PayrollView(staff: .constant(sampleStaff))
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
