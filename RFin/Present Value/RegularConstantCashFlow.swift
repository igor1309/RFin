//
//  RegularConstantCashFlow.swift
//  PresentValue
//
//  Created by Igor Malyarov on 13.02.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

/// The PV function returns the present value of an investment or annuity based on a series of regular periodic cash flows (payments of a constant amount and all cash flows at constant intervals) and at a fixed interest rate.
struct RegularConstantCashFlow: Identifiable, Codable {
    var id = UUID()
    
    /// regular periodic cash flows
    var payment: Double
    /// cash flow period
    var lifetimeType: LifetimeType = .perpetual
    /// lifetime in years
    var lifetime: Int
    /// fixed interest rate
    var annualRate: Double
    /// constant interval
    var period: Period
    
    enum Period: String, CaseIterable, Codable {
        case day, week, month, year
        
        var id: String { rawValue }
    }
    
    enum LifetimeType: String, CaseIterable, Codable {
        case finite
        case perpetual
        
        var id: String { rawValue }
    }
}

extension RegularConstantCashFlow {
    private var noOfPeriodsInYear: Double {
        switch period {
        case .day:
            return 365
        case .week:
            return 52
        case .month:
            return 12
        case .year:
            return 1
        }
    }
    
    private var periodicRate: Double {
        annualRate / noOfPeriodsInYear
    }
    
    private var noOfPeriods: Double? {
        switch lifetimeType {
        case .finite:
            return noOfPeriodsInYear * Double(lifetime)
        case .perpetual:
            return nil
        }
    }
    
    var pv: Double {
        switch lifetimeType {
        case .finite:
            // TODO: FIX THIS
            var sum = 0.0
            for i in 0..<Int(noOfPeriods!) {
                sum += 1 / pow(1 + periodicRate, Double(i+1))
            }
            return payment * sum
        case .perpetual:
            return  payment / periodicRate
        }
    }
    
    func explanation(_ multiplier: Int = 1) -> String {
        var s: String
        
        switch lifetimeType {
        case .perpetual:
            s = "perpetually"
        case .finite:
            s = "for \(lifetime) year\(lifetime == 1 ? "" : "s")"
        }
        
        let multipliedPayment = payment * Double(multiplier)
        let paymentStr = multiplier == 1 ? multipliedPayment.formattedGrouped : multipliedPayment.threeSignificantDigits

        let multipliedPV = pv * Double(multiplier)
        let equivalentStr1 = multipliedPV.threeSignificantDigits
        let equivalentStr2 = multiplier == 1 ? "" : " (\(multipliedPV.formattedGrouped))"
        
        return "Receiving \(paymentStr) every \(period.id) \(s) is equivalent to \(equivalentStr1)\(equivalentStr2) now (annual discount rate \(annualRate.formattedPercentage))."
    }
}

extension RegularConstantCashFlow {
    public static var example = RegularConstantCashFlow(payment: 10, lifetimeType: .finite, lifetime: 20, annualRate: 3/100, period: .month)
}
