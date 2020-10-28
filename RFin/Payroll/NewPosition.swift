//
//  NewPosition.swift
//  Payroll
//
//  Created by Igor Malyarov on 03.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct NewPosition: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @Binding var staff: Staff
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sampleStaff.divisions, id: \.self) { division in
                    
                    Section(header: Text(division.id)
                        .foregroundColor(.primary)) {
                            
                            ForEach(sampleStaff.positions
                                .filter({ $0.division == division })
                                .sorted(by: { $0.payPerWeekBrutto > $1.payPerWeekBrutto }), id: \.self) { position in
                                    
                                    NewPositionRow(staff: self.$staff, position: position)
                                        .contentShape(Rectangle())
                            }
                    }
                }
            }
            .listStyle(GroupedListStyle())
                
            .navigationBarTitle("Add Position")
                
            .navigationBarItems(trailing: TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct NewPosition_Previews: PreviewProvider {
    static var previews: some View {
        NewPosition(staff: .constant(sampleStaff))
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
