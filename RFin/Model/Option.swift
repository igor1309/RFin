//
//  Option.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

struct Option: Identifiable, Codable, Hashable {
    var id = UUID()
    
    /// QuickPL params
    var investment: Double
    var cashEarnings: Double
    
    /// ROI params
    var grace = 6
    var estPeriodInMonths = 60
    var investorsShareBeforeReturn: Double = 1.00
    var investorsShareAfterReturn: Double = 0.65
}

extension Option {
    var otbivka: Otbivka {
        Otbivka(name: investment.formattedGrouped + randomString(length: 4),
                investment: investment,
                investorsShareBeforeReturn: investorsShareBeforeReturn,
                investorsShareAfterReturn: investorsShareAfterReturn,
                monthsToReturnInvestment: Int((investment / cashEarnings / investorsShareBeforeReturn).rounded(.up)) + grace,
                estPeriodInMonths: estPeriodInMonths)
    }
}

extension Option {
    init(from item: Option) {
        self.investment = item.investment
        self.cashEarnings = item.cashEarnings
        self.grace = item.grace
        self.estPeriodInMonths = item.estPeriodInMonths
        self.investorsShareBeforeReturn = item.investorsShareBeforeReturn
        self.investorsShareAfterReturn = item.investorsShareAfterReturn
    }
}
