//
//  WeeklyMonthlyDpt.swift
//  Payroll
//
//  Created by Igor Malyarov on 03.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct WeeklyMonthlyDpt: View {
    @EnvironmentObject var userData: UserData
    var staff: Staff
    var product: Product?
    var division: Division?
    
    var body: some View {
        WeeklyMonthly(weeklyBrutto:        staff.payroll(product: product,
                                                         division: division,
                                                         type: .weeklyBrutto),
                      weeklyBruttoBrutto:  staff.payroll(product: product,
                                                         division: division,
                                                         type: .weeklyBruttoBrutto),
                      monthlyBrutto:       staff.payroll(product: product,
                                                         division: division,
                                                         type: .monthlyBrutto),
                      monthlyBruttoBrutto: staff.payroll(product: product,
                                                         division: division,
                                                         type: .monthlyBruttoBrutto))
    }
}

struct WeeklyMonthlyDpt_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeeklyMonthlyDpt(staff: sampleStaff, division: .kitchen)
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
