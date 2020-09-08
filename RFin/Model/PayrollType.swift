//
//  PayrollType.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum PayrollType: String, CaseIterable {
    case headcount = "Headcount"
    case hoursPerWeek = "Hours Per Week"
    case weeklyBrutto = "Weekly Brutto"
    case weeklyBruttoBrutto = "Weekly Brutto Brutto"
    case monthlyBrutto = "Monthly Brutto"
    case monthlyBruttoBrutto = "Monthly Brutto Brutto"
    case avgPayPerHourBrutto = "Avg Pay Per Hour Brutto"
    case avgPayPerHourBruttoBrutto = "Avg Pay Per Hour Brutto Brutto"
    
    var id: String { rawValue }
}
