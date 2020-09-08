//
//  QuickPL.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct QuickPL: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var investment: Double = 600_000
    var depreciationPeriodForTaxation: Int = 7
    var taxRate: Double = 0.3
    var currency: Currency = .euro
    
    var noOfCoversPerWeek: Int = 490
    var coverPriceVAT: Double = 65.5
    
    var foodcostPercentage: Double = 0.25
    var payrollRate: Int// = 50_000
    var rentRate: Int = 7_000
    var utilitiesPercentage: Double = 0.017
    var creditCardsProcessingPercentage: Double = 0.019
    var booksRate: Int = 2_200
    var marketingPercentage: Double = 0.018
    var allOtherExpensesPercentage: Double = 0.029

    /// Maintenance Capital Expenditures
    /// from Average Annual Maintenance Capital Expenditures
    /// http://www.arborinvestmentplanner.com/types-of-cash-flow-cash-flow-calculations-guide/
    var mcePercentage: Double = 0.3

}

extension QuickPL {
    init(from item: QuickPL) {
        self.investment = item.investment
        self.depreciationPeriodForTaxation = item.depreciationPeriodForTaxation
        self.taxRate = item.taxRate
        self.currency = item.currency
        
        self.noOfCoversPerWeek = item.noOfCoversPerWeek
        self.coverPriceVAT = item.coverPriceVAT
        
        self.foodcostPercentage = item.foodcostPercentage
        self.payrollRate = item.payrollRate
        self.rentRate = item.rentRate
        self.utilitiesPercentage = item.utilitiesPercentage
        self.creditCardsProcessingPercentage = item.creditCardsProcessingPercentage
        self.booksRate = item.booksRate
        self.marketingPercentage = item.marketingPercentage
        self.allOtherExpensesPercentage = item.allOtherExpensesPercentage
        self.mcePercentage = item.mcePercentage
    }
}

extension QuickPL {
    /// init with `ramdom` values
    init(currency: Currency = .euro) {
        self.currency = currency
        self.noOfCoversPerWeek = Int.random(in: 20...100) * 10
        self.foodcostPercentage = Double.random(in: 20...40) / 100
        
        if currency == .rub {
            self.investment = 30_000_000
            self.taxRate = 0.2
            self.coverPriceVAT = Double.random(in: 3...50) * 100
//            self.payrollRate = Int.random(in: 500...5_000) * 1_000
            self.rentRate = Int.random(in: 500...2_000) * 1_000
            self.booksRate = 200_000
        } else {
            self.investment = 600_000
            self.coverPriceVAT = Double.random(in: 0.8...15).rounded(toPlaces: 0) * 10
//            self.payrollRate = Int.random(in: 20...100) * 1_000
            self.rentRate = Int.random(in: 2...20) * 1000
            self.booksRate = 2_200
        }
        
        self.payrollRate = Int(Double.random(in: 0.18...0.50) * Double(noOfCoversPerWeek) * coverPriceVAT / 7 * 30)
        self.mcePercentage = Double.random(in: 0...0.25).rounded(toPlaces: 2)
    }
}

/// `Cover Price ex VAT`
extension QuickPL {
    var coverPrice: Double { coverPriceVAT / (1 + vat) }
}

/// `VAT`
extension QuickPL {
    var vat: Double {
        switch currency {
        case .euro:
            return 0.19
        case .rub:
            return 0.20
        default:
            return 0.20
        }
    }
}

///  `CAPEX`
extension QuickPL {
    var capex: Double { investment }
    
    var capexPercentage: Double {
        if revenuePerMonth != 0 {
            return capex / (revenuePerMonth * 12)
        } else {
            return 0
        }
    }
    var depreciation: Double {
        if depreciationPeriodForTaxation != 0 {
            return capex / Double(depreciationPeriodForTaxation) / 12
        } else {
            return 0
        }
    }
    var depreciationPercentage: Double {
        if revenuePerMonth != 0 {
            return depreciation / revenuePerMonth
        } else {
            return 0
        }
    }
}

///  `Revenue` with and without VAT
extension QuickPL {
    var revenuePerDay: Double { coverPrice * Double(noOfCoversPerWeek) / 7 }
    var revenuePerWeek: Double { coverPrice * Double(noOfCoversPerWeek) }
    var revenuePerMonth: Double { coverPrice * Double(noOfCoversPerWeek) / 7 * 365 / 12 }
    var revenuePerYear: Double { coverPrice * Double(noOfCoversPerWeek) / 7 * 365 }
    
    var revenuePerDayVAT: Double { revenuePerDay * (1 + vat) }
    var revenuePerWeekVAT: Double { revenuePerWeek * (1 + vat) }
    var revenuePerMonthVAT: Double { revenuePerMonth * (1 + vat) }
    var revenuePerYearVAT: Double { revenuePerYear * (1 + vat) }
}

///  `Costs`
extension QuickPL {
    var foodcost: Double { revenuePerMonth * foodcostPercentage }
    
    var payroll: Double { Double(payrollRate) }
    var payrollPercentage: Double {
        if revenuePerMonth != 0 {
            return payroll / revenuePerMonth
        } else {
            return 0
        }
    }
    var rent: Double { Double(rentRate) }
    var rentPercentage: Double {
        if revenuePerMonth != 0 {
            return rent / revenuePerMonth
        } else {
            return 0
        }
    }
    var utilities: Double { revenuePerMonth * utilitiesPercentage }
    var creditCardsProcessing: Double { revenuePerMonthVAT * creditCardsProcessingPercentage }
    var books: Double { Double(booksRate) }
    var booksPercentage: Double {
        if revenuePerMonth != 0 {
            return books / revenuePerMonth
        } else {
            return 0
        }
    }
    var marketing: Double { revenuePerMonth * marketingPercentage }
    var allOtherExpenses: Double { revenuePerMonth * allOtherExpensesPercentage }
    
    var costs: Double {
        foodcost + payroll + rent + utilities + creditCardsProcessing + books + marketing + allOtherExpenses
    }
    var costsPercentage: Double {
        if revenuePerMonth != 0 {
            return costs / revenuePerMonth
        } else {
            return 0
        }
    }
    var primeCost: Double { foodcost + payroll }
    var primeCostPercentage: Double {
        if revenuePerMonth != 0 {
            return primeCost / revenuePerMonth
        } else {
            return 0
        }
    }
    
    var fixedCosts: Double { rent + utilities + books + marketing + allOtherExpenses }
    var fixedCostsPercentage: Double {
        if revenuePerMonth != 0 {
            return fixedCosts / revenuePerMonth
        } else {
            return 0
        }
    }
}

/// `Financial Result`
extension QuickPL {
    var ebitda: Double { revenuePerMonth - costs }
    var ebitdaPercentage: Double {
        if revenuePerMonth != 0 {
            return ebitda / revenuePerMonth
        } else {
            return 0
        }
    }
    var ebit: Double { ebitda - depreciation }
    var ebitPercentage: Double {
        if revenuePerMonth != 0 {
            return ebit / revenuePerMonth
        } else {
            return 0
        }
    }
    var profit: Double { ebit - tax }
    var profitPercentage: Double {
        if revenuePerMonth != 0 {
            return profit / revenuePerMonth
        } else {
            return 0
        }
    }
}

/// `Income Tax`
extension QuickPL {
    var tax: Double { ebit * taxRate }
    var taxPercentage: Double {
        if revenuePerMonth != 0 {
            return tax / revenuePerMonth
        } else {
            return 0
        }
    }
}

/// `Net Cash Flow`
extension QuickPL {
    var cashEarnings: Double { profit + depreciation }
    var cashEarningsPercentage: Double {
        if revenuePerMonth != 0 {
            return cashEarnings / revenuePerMonth
        } else {
            return 0
        }
    }
    var investmentToNetCashFlow: Double {
        if cashEarnings != 0 {
            return (capex / cashEarnings).rounded(.up)
        } else {
            return 0
        }
    }
    var mce: Double { mcePercentage * cashEarnings }
    var ownerEarnings: Double {
        cashEarnings - mce
    }
    var ownerEarningsPercentage: Double {
        if revenuePerMonth != 0 {
            return ownerEarnings / revenuePerMonth
        } else {
            return 0
        }
    }
}
