//
//  Benchmark.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 07.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum BenchmarkGroup: String, CaseIterable, Codable, Hashable, Equatable {
    case operations = "Operations"
    case sales = "Sales"
    case finance = "Finance"
    case productivity = "Productivity"
    case staff = "Staff"
    case other = "Other"
    case customer = "Customer Behavior"
    
    var id: String { rawValue }
}

struct Benchmark: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var isImportant: Bool
    var groups: [BenchmarkGroup]
    /// не все бенчмарки буду реализовывать сразу,
    /// но некоторые интересно иметь на будущее
    var value: Double?
    
    /// target could be a range or value
    var targetRange: ClosedRange<Double>?
    var targetValue: Double?
    
    var isInRange: Bool {
        targetRange?.contains(value ?? -1) ?? false
    }
    
    var description: String
}

extension Analytics {
    func update(benchmark: Benchmark, with draft: Benchmark) {
        //  MARK: додумать и доделать
    }
}

struct Analytics {
    var restaurant: Restaurant
    
    /// sources:
    /// http://info.bloomintelligence.com/hubfs/Miscellaneous%20Downloads/Restaurant%20Benchmarks.pdf
    
    var benchmarks: [Benchmark] {
        [
            Benchmark(name: "Food Cost",
                      isImportant: true,
                      groups: [.operations],
                      value: (restaurant.foodcost / restaurant.revenue).rounded(toPlaces: 2),
                      targetRange: 0.2...0.3,
                      targetValue: 0.25,
                      description: "This metric measures the percentage of each sales dollar required to cover the cost of food, beverage, and paper supplies, net of any vendor rebates."),
            Benchmark(name: "Labor Cost",
                      isImportant: true,
                      groups: [.operations, .productivity],
                      value: (restaurant.labor / restaurant.revenue).rounded(toPlaces: 2),
                      targetRange: 0.12...0.32,
                      targetValue: 0.25,
                      description: "This metric measures the percentage of each sales dollar required to cover the cost of store labor."),
            Benchmark(name: "Prime Cost",
                      isImportant: true,
                      groups: [.operations],
                      targetRange: 0.4...0.55,
                      targetValue: 0.5,
                      description: "This metric combines the food cost and store labor percentages, which are considered the two most significant restaurant costs."),
            Benchmark(name: "EBITDAR percentage",
                      isImportant: false,
                      groups: [.operations],
                      targetValue: 11,
                      description: "Full service – 11.0 / QSR – 12.8. EBITDAR stands for Earnings Before Interest, Taxes, Depreciation, Amortization, and Rent. It represents the amount of cash available to cover fixed charges – rent and debt service."),
            Benchmark(name: "Alcoholic Beverage Costs",
                      isImportant: true,
                      groups: [.other],
                      description: "• Liquor: 18% - 20% of liquor sales\n• Bar consumables: 4% - 5% of liquor sales\n• Bottled beer: 24% - 28% of bottle beer sales\n• Draft beer: 15% - 18% of draft beer sales\n• Wine: 35% - 45% of wine sales"),
            Benchmark(name: "Non-alcoholic Beverage Costs",
                      isImportant: true,
                      groups: [.other],
                      description: "• Soft drinks: 10% - 15% of soft drink sales\n• Coffee: 15% - 20% of coffee sales\n• Iced Tea: 5% - 10% of iced tea sales"),
            Benchmark(name: "Paper Cost",
                      isImportant: true,
                      groups: [.other],
                      targetRange: 0.01...0.02,
                      description: "• Full service: 1% - 2% of total sales\n• Limited-service: 3% - 4% of total sales"),
            Benchmark(name: "Payroll Cost",
                      isImportant: true,
                      groups: [.staff, .other],
                      targetRange: 0.25...0.30,
                      description: "• Full service: 30% - 35% of total sales\n• Limited-service: 25% - 30% of total sales\n• Management salaries: 10% or less of total sales"),
            Benchmark(name: "Management salaries",
                      isImportant: true,
                      groups: [.staff, .other],
                      targetRange: 0.03...0.10,
                      description: "• Full service: 30% - 35% of total sales\n• Limited-service: 25% - 30% of total sales\n• Management salaries: 10% or less of total sales"),
            Benchmark(name: "Employee Benefits",
                      isImportant: false,
                      groups: [.staff, .other],
                      targetRange: 0.05...0.06,
                      description: "• 5% - 6% of total sales"),
            Benchmark(name: "Employee Benefits",
                      isImportant: false,
                      groups: [.staff, .other],
                      targetRange: 0.2...0.23,
                      description: "20% - 23% of gross payroll"),
            Benchmark(name: "Rent",
                      isImportant: true,
                      groups: [.operations, .other],
                      targetRange: 0.03...0.06,
                      description: "Rent: 6% or less of total sales"),
            Benchmark(name: "Occupancy",
                      isImportant: true,
                      groups: [.operations, .other],
                      targetRange: 0.04...0.1,
                      description: "Occupancy: 10% or less of total sales"),
            Benchmark(name: "SALES PER SQUARE FOOT",
                      isImportant: true,
                      groups: [.sales],
                      targetValue: 500,
                      description: "To calculate sales per square foot, divide annual sales by the total interior square footage including kitchen, dining, storage, rest rooms, etc. This is usually equal to the net rentable square feet in a leased space.\n\nFull-service\n• Under $150/square foot = little chance of generating profit\n• $150 - $250/square foot = break-even up to 5% of sales\n• $250 - $325/square foot = 5% - 10% of sales\n\nLimited-service\n• Under $200/square foot = little chance of avoiding a loss\n• $200 - $300/square foot = break-even up to 5% of sales\n• $300 - $400/square foot = 5% - 10% of sales before income taxes"),
            Benchmark(name: "Sales to Investment Ratio",
                      isImportant: true,
                      groups: [.finance],
                      targetValue: 1,
                      description: "ПОХОЖЕ НА БРЕД. 10 лет окупаемость. Full service – 1.0 / QSR – 1.0\nThis metric measures sales against investment in real estate and equipment."),
            Benchmark(name: "Debt to EBITDA",
                      isImportant: false,
                      groups: [.finance],
                      description: "Full service – 3.1 / QSR – 3.9\nThis metric measures the ability to repay debt, from banks or other sources, over the long term."),
            Benchmark(name: "Funded Debt to EBITDAR",
                      isImportant: false,
                      groups: [.finance],
                      description: "Full service – 5.2 / QSR – 5.7\nThis metric measures the ability to cover fixed charges (debt service and rent) over the long term."),
            Benchmark(name: "Debt Service Coverage",
                      isImportant: false,
                      groups: [.finance],
                      description: "Full service – 1.8 / QSR – 1.1\nThis metric measures the ability to pay off debt in the short term."),
            Benchmark(name: "Fixed Charge Coverage",
                      isImportant: false,
                      groups: [.finance],
                      description: "Full service – 1.3 / QSR – 1.1\nThis metric measures the ability to cover fixed charges (debt service and rent) in the near term."),
            Benchmark(name: "Effective Interest Rate",
                      isImportant: false,
                      groups: [.finance],
                      description: "Full service – 4.1 / QSR – 4.8\nThis metric measures the cost of borrowing."),
            Benchmark(name: "NBV as % of Cost",
                      isImportant: false,
                      groups: [.finance],
                      description: "Full service – 44.2 / QSR – 51.3\nNet Book Value as a % of Cost measures the relative age of building, equipment and furnishings."),
            Benchmark(name: "Average Customer Dwell Time",
                      isImportant: false,
                      groups: [.customer],
                      targetValue: 64.7,
                      description: "64.7 minutes. This metric represents customers’ average visit time in minutes."),
            Benchmark(name: "First-Time Visitors (average daily)",
                      isImportant: false,
                      groups: [.customer],
                      targetValue: 120,
                      description: "120 visitors. This metric measures the average daily number of first-time customers at a single location."),
            Benchmark(name: "First-Time Visitor Return Rate",
                      isImportant: false,
                      groups: [.customer],
                      targetValue: 0.288,
                      description: "28.8%. This is the number of first-time customers within the past 12 months who returned again at least once. The rate is given as the percentage of all customers within the last 12 months."),
            Benchmark(name: "Average Monthly Customer Repeat Rate",
                      isImportant: false,
                      groups: [.customer],
                      targetValue: 1.83,
                      description: "1.83 repeat visits. The average frequency a customer visits a location in a month."),
            Benchmark(name: "Average Customer Churn (Attrition) Rate",
                      isImportant: false,
                      groups: [.customer],
                      targetValue: 0.114,
                      description: "11.4%. The percentage of customers who failed to return to the location during the past 12 months.")
        ]
    }
}
