//
//  NewPositionRow.swift
//  Payroll
//
//  Created by Igor Malyarov on 03.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct NewPositionRow: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @Binding var staff: Staff
    var position: Position
    
    @State private var showDetail = false
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        HStack {
            Text(position.name)
                .foregroundColor(.systemOrange)
            Spacer()
            Text("\(currency.idd)\(position.payPerHourBrutto.formattedGrouped) x \(position.hoursPerWeek.formattedGrouped) h/week")
                .foregroundColor(.secondary)
        }
        .onTapGesture {
            self.createAndPresent()
        }
            
        .sheet(isPresented: $showDetail) {
            PayrollDetail(staff: self.$staff, position: self.position)
                .environmentObject(self.userData)
        }
    }
    
    private func createAndPresent() {
        self.presentation.wrappedValue.dismiss()
        staff.add(position)
        self.showDetail = true
    }
}

struct NewPositionRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewPositionRow(staff: .constant(sampleStaff), position: sampleStaff.positions[0])
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
