//
//  Estimate.swift
//  RFin
//
//  Created by Igor Malyarov on 27.02.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Estimate {
    var venture: Venture
    
    /// срок возврата инвестиций в месяцах
    var periodInMonths: Int
    
    /// период выхода проекта на целевую мощность в месяцах
    /// в этом периоде выплаты не производятся
    var graceIfMonths: Int = 6
    
    /// период (горизонт) оценки доходности проекта в месяцах
    var horizonInMonths: Int
    
}

extension Estimate {
    
    ///  `Periods in Years`
    var yearsToReturnInvestment: Double {
        Double(periodInMonths) / 12
    }
    var graceInYears: Double {
        Double(graceIfMonths) / 12
    }
    var horizonInYears: Double {
        Double(horizonInMonths) / 12
    }
    
    
    ///  `OP Share`
    var opShareBeforeReturn: Double {
        1 - venture.investorsShareBeforeReturn
    }
    var opShareAfterReturn: Double {
        1 - venture.investorsShareAfterReturn
    }
    
    
    ///  `Distribution`
    ///  total distribution to Investor
    var investorsDistribution: Double {
        flows.reduce(venture.investment) { $0 + $1.flowToInvestor }
    }
    var investorsProfit: Double {
        flows.reduce(0) { $0 + $1.flowToInvestor }
    }
    //  total distribution to Operational Partner
    var opDistribution: Double {
        flows.reduce(0) { $0 + $1.flowToOP }
    }
    
    /// per month
    var distributionPerMonth: Double {
        venture.investment / venture.investorsShareBeforeReturn / Double(periodInMonths - graceIfMonths)
    }
    var investorsDistributionPerMonthBeforeReturn: Double {
        distributionPerMonth * venture.investorsShareBeforeReturn
    }
    var investorsDistributionPerMonthAfterReturn: Double {
        distributionPerMonth * venture.investorsShareAfterReturn
    }
    var opDistributionPerMonthBeforeReturn: Double {
        distributionPerMonth * opShareBeforeReturn
    }
    var opDistributionPerMonthAfterReturn: Double {
        distributionPerMonth * opShareAfterReturn
    }
    
    /// per year
    var distributionPerYear: Double {
        distributionPerMonth * 12
    }
    var investorsDistributionPerYearBeforeReturn: Double {
        distributionPerYear * venture.investorsShareBeforeReturn
    }
    var investorsDistributionPerYearAfterReturn: Double {
        distributionPerYear * venture.investorsShareAfterReturn
    }
    var opDistributionPerYearBeforeReturn: Double {
        distributionPerYear * opShareBeforeReturn
    }
    var opDistributionPerYearAfterReturn: Double {
        distributionPerYear * opShareAfterReturn
    }
    
    
    ///  `Flows`
    /// эти потоки используются для визуализации (таблица потоков)
    typealias Flow = (name: String, flowToInvestor: Double, flowToOP: Double)
    
    var flows: [Flow] {
        if horizonInMonths < 1 { return [] }
        if periodInMonths == graceIfMonths { return [] }
        
        var streams: [Flow] = [("init", -venture.investment, 0)]
        
        for i in 1...horizonInMonths {
            var flow: Flow
            
            if i <= graceIfMonths {
                flow = ("grace", 0, 0)
            } else if i <= periodInMonths {
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
    
    ///  `IRR`
    /// эти потоки используются для расчета IRR
    /// потоки в этой модели не зависят от суммы инвестиций, только от сроков
    /// (возврата, грейса и горизонта оценки)
    var flowsForIRR: [Double] {
        if horizonInMonths < 1 { return [] }
        if periodInMonths == graceIfMonths { return [] }
        
        var streams: [Double] = [-1]
        
        for i in 1...horizonInMonths {
            var flow: Double
            
            if i <= graceIfMonths {
                flow = 0
            } else if i <= periodInMonths {
                flow = 1 / Double(periodInMonths - graceIfMonths)
            } else {
                flow = venture.investorsShareAfterReturn / venture.investorsShareBeforeReturn / Double(periodInMonths - graceIfMonths)
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


