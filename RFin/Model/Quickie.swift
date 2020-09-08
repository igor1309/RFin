//
//  Quickie.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Quickie: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var quickPLs: [QuickPL]
}

extension Quickie {
    var usedCurrencies: [Currency] { quickPLs.map { $0.currency }.removingDuplicates() }
    
    var pairs: [Pair] {
        quickPLs.map { Pair(investment: $0.investment, coverPriceVAT: $0.coverPriceVAT) }
            .removingDuplicates()
    }
}

extension Quickie {
    mutating func add(_ item: QuickPL) {
        quickPLs.insert(QuickPL(from: item), at: 0)
    }
    mutating func addRandom() {
        let randomCurrency = Currency.allCases
            .filter { $0 != .none }
            .randomElement()
        add(QuickPL(currency: randomCurrency!))
    }
    mutating func update(_ item: QuickPL, with newItem: QuickPL) -> Bool {
        if item == newItem {
            print("items are identical, nothing to update")
            return true }
        
        guard let index = quickPLs.firstIndex(of: item) else {
            print("index for item not found")
            return false }
        
        quickPLs[index] = QuickPL(from: newItem)
        print("item updated successfully")
        return true
    }
    mutating func delete(_ item: QuickPL) -> Bool {
        guard let index = quickPLs.firstIndex(of: item) else { return false }
        
        quickPLs.remove(at: index)
        return true
    }
    mutating func reset() {
        quickPLs.removeAll()
    }
    mutating func replaceWithSampleData() {
        quickPLs.removeAll()
        quickPLs = sampleQuickie.quickPLs
    }
    mutating func addAllSampleData() {
        for item in sampleQuickie.quickPLs.reversed() {
            add(item)
        }
    }
    
}
