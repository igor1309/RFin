//
//  Position.swift
//  Staff
//
//  Created by Igor Malyarov on 02.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

//  MARK: move to restaurant setting
//let payrollTax = 0.25

struct Position: Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var division: Division
    var product: Product
    var qty: Int
    
    var hoursPerWeek: Double = 40
    var lateHoursPerWeek: Double = 0
    var nightHoursPerWeek: Double = 0
    
    var payPerHourBrutto: Double = 10
    var lateHourBonusRate: Double = 0.25
    var nightHourBonusRate: Double = 0.40
    
    var normalHoursTaxRate: Double = 0.20   //  Employer's contributions total
    var lateHoursTaxRate: Double = 0
    var nightHoursTaxRate: Double = 0
}

extension Position {
    init(from position: Position) {
//        self.id = UUID()

        self.name = position.name
        self.division = position.division
        self.product = position.product
        self.qty = position.qty

        self.hoursPerWeek = position.hoursPerWeek
        self.lateHoursPerWeek = position.lateHoursPerWeek
        self.nightHoursPerWeek = position.nightHoursPerWeek

        self.payPerHourBrutto = position.payPerHourBrutto
        self.lateHourBonusRate = position.lateHourBonusRate
        self.nightHourBonusRate = position.nightHourBonusRate

        self.normalHoursTaxRate = position.normalHoursTaxRate
        self.lateHoursTaxRate = position.lateHoursTaxRate
        self.nightHoursTaxRate = position.nightHoursTaxRate
    }
}

extension Position {
    var payPerHourBruttoBrutto: Double {
        payPerHourBrutto * (1 + normalHoursTaxRate)
    }
    var totalPayPerHourBrutto: Double {     // including bonuses
        if hoursPerWeek == 0 {
            return 0
        } else {
            return payPerWeekBrutto / hoursPerWeek
        }
    }
    var totalPayPerHourBruttoBrutto: Double {
        if hoursPerWeek == 0 {
            return 0
        } else {
            return payPerWeekBruttoBrutto / hoursPerWeek
        }
    }
    var payPerWeekBrutto: Double {
        payPerHourBrutto * (hoursPerWeek +
            lateHoursPerWeek * lateHourBonusRate +
            nightHoursPerWeek * nightHourBonusRate)
    }
    var payPerWeekBruttoBrutto: Double {
        payPerHourBrutto * (hoursPerWeek * (1 + normalHoursTaxRate) +
            lateHoursPerWeek * lateHourBonusRate * (1 + lateHoursTaxRate) +
            nightHoursPerWeek * nightHourBonusRate * (1 + nightHoursTaxRate))
    }
    var payPerMonthBrutto: Double {
        payPerWeekBrutto / 7 * 365 / 12
    }
    var payPerMonthBruttoBrutto: Double {
        payPerWeekBruttoBrutto / 7 * 365 / 12
    }
}
