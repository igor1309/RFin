//
//  StaffVersionRow.swift
//  RFin
//
//  Created by Igor Malyarov on 12.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct StaffVersionRow: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    var hapticsAvailable: Bool { CHHapticEngine.capabilitiesForHardware().supportsHaptics }
    
    var staff: Staff
    
    var index: Int { userData.restaurant.staffVersions.versions.firstIndex(where: { $0.id == staff.id })! }
    
    @State private var showDeleteConfirmation = false
    @State private var showModal = false
    @State private var modal: ModalType = .detail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(staff.name)
                    .foregroundColor(.systemOrange)
                
                Spacer()
                Text(Date().toString())
                    .font(.caption)
                    .foregroundColor(.systemRed)
                    .foregroundColor(.secondary)
            }
            
            StaffSummary(staff: staff)
         
            HStack {
                Text(staff.productList.joined(separator: ", "))
                Spacer()
                Text(staff.divisionList.joined(separator: ", "))
            }
            .font(.caption)
            .foregroundColor(.systemTeal)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.modal = .groups
            self.showModal = true
        }
        .sheet(isPresented: self.$showModal) {
            if self.modal == .detail {
                PayrollView(staff: self.$userData.restaurant.staffVersions.versions[self.index])
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
            }
            if self.modal == .groups {
                PayrollGroupedView(staff: self.staff)
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
            }
            if self.modal == .matrix {
                PayrollMatrix(staff: self.staff)
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
            }
            if self.modal == .superMatrix {
                PayrollSuperMatrix(staff: self.staff)
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
            }
        }
        .contextMenu {
            /// Show Positions
            Button(action: {
                self.modal = .detail
                self.showModal = true
            }) {
                Image(systemName: "person.2")
                Text("Payroll by Position")
            }
            
            /// Show  Data by Divisions
            Button(action: {
                self.modal = .groups
                self.showModal = true
            }) {
                Image(systemName: "person.crop.rectangle")
                Text("Grouped")
            }
            
            /// Matriix
            Button(action: {
                self.modal = .matrix
                self.showModal = true
            }) {
                Image(systemName: "square.grid.4x3.fill")
                Text("Matrix")
            }
            
            /// Super Matriix
            Button(action: {
                self.modal = .superMatrix
                self.showModal = true
            }) {
                Image(systemName: "circle.grid.3x3")
                Text("Super Matrix")
            }
            
            /// Duplicate Staff Version
            Button(action: {
                self.duplicate(self.staff)
            }) {
                Image(systemName: "plus.square.on.square")
                Text("Duplicate \("Staff Version")")
            }
            
            /// Delete Staff Version
            Button(action: {
                self.showDeleteConfirmation = true
            }) {
                Image(systemName: "trash.circle")
                Text("Delete \("Staff Version")")
            }
            .actionSheet(isPresented: self.$showDeleteConfirmation) {
                ActionSheet(title: Text("Delete?".uppercased()),
                            message: Text("Do you really want to delete this Staff Option? This cannot be undone"),
                            buttons: [.cancel(),
                                      .destructive(Text("Yes, delete")) {
                                        self.delete(self.staff)
                                }])
            }
        }
    }
    
    func duplicate(_ staff: Staff) {
        userData.restaurant.staffVersions.duplicate(staff)
        
        if self.hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    func delete(_ staff: Staff) {
        userData.restaurant.staffVersions.delete(staff)
        
        if self.hapticsAvailable {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}

struct StaffVersionRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(0..<5) { _ in
                StaffVersionRow(staff: sampleStaff)
            }
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}
