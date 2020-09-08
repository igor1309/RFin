//
//  Scenario.swift
//  RFin
//
//  Created by Igor Malyarov on 16.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Scenario: Codable {
    var id = UUID()
    
    var investment: Double { didSet { update() }}
    var noOfCoversPerWeek: Int { didSet { update() }}
    var payrollRate: Int { didSet { update() }}
    
    var grace = 6
    var estPeriodInMonths = 60 { didSet { update() }}
    
    var quickPL: QuickPL
    var options: [Option]
    
    var modificationDate = Date()
    
    init(from quickPL: QuickPL) {
        let correctedInvestment = quickPL.investmentToNetCashFlow.rounded(.up) * quickPL.cashEarnings.rounded(.up)
        
        self.quickPL = quickPL
        self.quickPL.investment = correctedInvestment
        
        self.investment = correctedInvestment
        self.noOfCoversPerWeek = quickPL.noOfCoversPerWeek
        self.payrollRate = quickPL.payrollRate
        
        self.options = sampleOptions
        self.updateOptions()
    }
}

extension Scenario {
    var isEmpty: Bool { options.isEmpty }
}
 
extension Scenario {
    mutating func updateQuickPL() {
        quickPL.investment = investment
        quickPL.noOfCoversPerWeek = noOfCoversPerWeek
        quickPL.payrollRate = payrollRate
    }
    
    mutating func updateOptions() {
        for index in options.indices {
            options[index].investment = investment
            options[index].cashEarnings = quickPL.cashEarnings
            options[index].grace = grace
            options[index].estPeriodInMonths = estPeriodInMonths
        }
    }
    
    mutating func update() {
        updateQuickPL()
        updateOptions()
        modificationDate = Date()
    }
    
    mutating func update(with quickPL: QuickPL) {
        self.quickPL = quickPL
        
        self.investment = quickPL.investment
        self.noOfCoversPerWeek = quickPL.noOfCoversPerWeek
        self.payrollRate = quickPL.payrollRate
        
        updateOptions()
        modificationDate = Date()
    }
    
    mutating func add(_ item: Option) {
        options.insert(item, at: 0)
    }
    
    mutating func addRandomOption() {
        let option = Option(investment: investment,
                            cashEarnings: quickPL.cashEarnings,
                            grace: grace,
                            estPeriodInMonths: estPeriodInMonths,
                            investorsShareBeforeReturn: Double.random(in: 0.5...1.0),
                            investorsShareAfterReturn: Double.random(in: 0.5...1.0))
        add(option)
    }
    
    mutating func update(_ item: Option, with newItem: Option) -> Bool {
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = options.firstIndex(of: item) else {
            print("index for item not found")
            return false }
        
        options[index] = Option(from: newItem)
        print("item updated successfully")
        return true
    }
    
    mutating func delete(_ item: Option) -> Bool {
        guard let index = options.firstIndex(of: item) else { return false }
        
        options.remove(at: index)
        return true
    }
    
    mutating func reset() {
        options.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        options = sampleOptions
        self.updateOptions()
    }
    
    mutating func addAllSampleData() {
        for option in sampleOptions.reversed() {
            add(option)
        }
    }
}
