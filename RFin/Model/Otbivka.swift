//
//  Otbivka.swift
//  Otbivka
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

/// в модели используется внутреняя оценка прибыльности проекта,
/// которая вычисляется исходя из оговоренных сроков возврата инвестиций
/// с учетом грейса (см ниже как считается distributionPerYear
struct Otbivka: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    
    var investment: Double
    var investorsShareBeforeReturn: Double
    var investorsShareAfterReturn: Double
    
    /// срок возврата инвестиций в месяцах
    var monthsToReturnInvestment: Int
    /// период выхода проекта на целевую мощность в месяцах
    /// в этом периоде выплаты не производятся
    var graceNumberOfMonths: Int = 6
    /// период (горизонт) оценки доходности проекта в месяцах
    var estPeriodInMonths: Int
    
    var modificationDate = Date()
}

extension Otbivka {
    init(random: Bool) {
        self.name = "Return \(randomString(length: 4))"
        self.investorsShareAfterReturn = 0.50
        
        if random {
            self.investment = Double.random(in: 300...40_000) * 1_000
            self.investorsShareBeforeReturn = Double.random(in: 0.6...1.0).rounded(toPlaces: 2)
            self.monthsToReturnInvestment = Int.random(in: 12...48)
            self.estPeriodInMonths = Int.random(in: 48...96)
        } else {
            self.investment = 30_000_000
            self.investorsShareBeforeReturn = 0.75
            self.monthsToReturnInvestment = 30
            self.estPeriodInMonths = 60
        }
    }
}

extension Otbivka {
    init(from item: Otbivka) {
        self.name = item.name
        self.investment = item.investment
        self.investorsShareBeforeReturn = item.investorsShareBeforeReturn
        self.investorsShareAfterReturn = item.investorsShareAfterReturn
        self.monthsToReturnInvestment = item.monthsToReturnInvestment
        self.estPeriodInMonths = item.estPeriodInMonths
        self.modificationDate = item.modificationDate
    }
}

//  Periods in Years
extension Otbivka {
    var yearsToReturnInvestment: Double {
        Double(monthsToReturnInvestment) / 12
    }
    var gracePeriodInYears: Double {
        Double(graceNumberOfMonths) / 12
    }
    var estimationPeriodInYears: Double {
        Double(estPeriodInMonths) / 12
    }
}

//  OP Share
extension Otbivka {
    var opShareBeforeReturn: Double {
        1 - investorsShareBeforeReturn
    }
    var opShareAfterReturn: Double {
        1 - investorsShareAfterReturn
    }
}

//  Distribution
extension Otbivka {
    //  total distribution to Investor
    var investorsDistribution: Double {
        flows.reduce(investment) { $0 + $1.flowToInvestor }
    }
    var investorsProfit: Double {
        flows.reduce(0) { $0 + $1.flowToInvestor }
    }
    //  total distribution to Operational Partner
    var opDistribution: Double {
        flows.reduce(0) { $0 + $1.flowToOP }
    }
}

/// per `month`
extension Otbivka {
    var distributionPerMonth: Double {
        investment / investorsShareBeforeReturn / Double(monthsToReturnInvestment - graceNumberOfMonths)
    }
    var investorsDistributionPerMonthBeforeReturn: Double {
        distributionPerMonth * investorsShareBeforeReturn
    }
    var investorsDistributionPerMonthAfterReturn: Double {
        distributionPerMonth * investorsShareAfterReturn
    }
    var opDistributionPerMonthBeforeReturn: Double {
        distributionPerMonth * opShareBeforeReturn
    }
    var opDistributionPerMonthAfterReturn: Double {
        distributionPerMonth * opShareAfterReturn
    }
}

/// per `year`
extension Otbivka {
    var distributionPerYear: Double {
        distributionPerMonth * 12
    }
    var investorsDistributionPerYearBeforeReturn: Double {
        distributionPerYear * investorsShareBeforeReturn
    }
    var investorsDistributionPerYearAfterReturn: Double {
        distributionPerYear * investorsShareAfterReturn
    }
    var opDistributionPerYearBeforeReturn: Double {
        distributionPerYear * opShareBeforeReturn
    }
    var opDistributionPerYearAfterReturn: Double {
        distributionPerYear * opShareAfterReturn
    }
}

//  Flows
extension Otbivka {
    /// эти потоки используются для визуализации (таблица потоков)
    typealias Flow = (name: String, flowToInvestor: Double, flowToOP: Double)
    
    var flows: [Flow] {
        if estPeriodInMonths < 1 { return [] }
        if monthsToReturnInvestment == graceNumberOfMonths { return [] }
        
        var streams: [Flow] = [("init", -investment, 0)]
        
        for i in 1...estPeriodInMonths {
            var flow: Flow
            
            if i <= graceNumberOfMonths {
                flow = ("grace", 0, 0)
            } else if i <= monthsToReturnInvestment {
                flow = ("◻︎ |  ",
                        investorsDistributionPerMonthBeforeReturn,
                        opDistributionPerMonthBeforeReturn)
            } else {
                flow = ("  | ◻︎",
                        investorsDistributionPerMonthAfterReturn,
                        opDistributionPerMonthAfterReturn)
            }
            
            streams.append(flow)
        }
        
        return streams
    }
}

//  IRR
extension Otbivka {
    /// эти потоки используются для расчета IRR
    /// потоки в этой модели не зависят от суммы инвестиций, только от сроков
    /// (возврата, грейса и горизонта оценки)
    var flowsForIRR: [Double] {
        if estPeriodInMonths < 1 { return [] }
        if monthsToReturnInvestment == graceNumberOfMonths { return [] }
        
        var streams: [Double] = [-1]
        
        for i in 1...estPeriodInMonths {
            var flow: Double
            
            if i <= graceNumberOfMonths {
                flow = 0
            } else if i <= monthsToReturnInvestment {
                flow = 1 / Double(monthsToReturnInvestment - graceNumberOfMonths)
            } else {
                flow = investorsShareAfterReturn / investorsShareBeforeReturn / Double(monthsToReturnInvestment - graceNumberOfMonths)
            }
            
            streams.append(flow)
        }
        
        return streams
    }
    
    ///  `IRR`. Could be no solution then return nil
    var irr: Double? {
        
//        _ = calculateIRR(flows: flowsForIRR)
        
        if let irr = calcIRRNewtonRaphson(flows: flowsForIRR) {
            /// потоки ежемесячные!!
            return irr * 12
        } else {
            return nil
        }
    }
}
