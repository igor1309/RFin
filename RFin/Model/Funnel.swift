//
//  Funnel.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

struct Funnel: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String // funnel for every sales channel
    var description: String

    var isRunning: Bool // по аналогии с isMealOffered компания может быть выключена (без удаления)
    var period: Period // день, неделя, месяц, год — период размещения
    
    //  Есть цена за трафик (top level of sales funnel/engagement: икс рублей за 1000 показов, зарплата промоутера за икс часов с оценкой трафика и так далее):
    var traffic: Double
    var unitOfTraffic: Double = 1_000 // например 1000 показов
    var pricePerUnitOfTraffic: Double   //  цена за 1000 показов
    
    //  уровни конверсии
    var levels: [Level] = []
}

extension Funnel {
    var budget: Double { pricePerUnitOfTraffic * traffic / unitOfTraffic }
    /// В итоге получаем:
    var guests: Double { bottom }
    var bottom: Double {    // количество сделок, гостей в ресторане, и так далее
        traffic * conversion
    }
    var conversion: Double {    // overall conversion rate through the sales funnnel
        levels.reduce(1, { $0 * $1.conversionRate })
    }
    var cps: Double? {   // Cost Per Sale/Cost Per Guest
        if bottom == 0 {
            return nil
        } else {
            return budget / bottom
        }
    }
}

extension Funnel {
    init(from item: Funnel) {
        self.name = item.name
        self.description = item.description
        self.isRunning = item.isRunning
        self.period = item.period
        self.traffic = item.traffic
        self.unitOfTraffic = item.unitOfTraffic
        self.pricePerUnitOfTraffic = item.pricePerUnitOfTraffic
        self.levels = item.levels
    }
}

extension Funnel {
    init(random: Bool) {
        if random {
            self.name = "Funnel \(randomString(length: 4))"
            self.description = randomString(length: 32)
            self.isRunning = Bool.random()
            self.traffic = Double(Int.random(in: 10...1_000) * 1_000)
            self.levels = sampleFunnels[0].levels
        } else {
            self.name = "Some Funnel"
            self.description = "Description for the Funnel"
            self.isRunning = true
            self.traffic = 1_000_000
            self.levels = [Level(random: false)]
        }
        self.pricePerUnitOfTraffic = 100
        self.unitOfTraffic = 1_000
        self.period = .week
    }
}

extension Funnel {
    var isListEmpty: Bool { levels.isEmpty }
}

extension Funnel {
    func isNameUsed(_ item: Level) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !levels.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return levels.contains(where: { $0.name == item.name })
        } else {
            return levels.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Level) {
        levels.insert(Level(from: item), at: 0)
    }
    
    mutating func addRandom() {
        add(Level(random: true))
    }
    
    mutating func duplicate(_ item: Level) {
        var newItem = Level(from: item)
        var newName = item.name + " Copy"
        while levels.map({ $0.name }).contains(newName) {
            newName += " Copy"
        }
        newItem.name = newName
        add(newItem)
    }
    
    mutating func update(_ item: Level, with newItem: Level) -> Bool {
        guard let index = levels.firstIndex(of: item) else {
            print("can't find item in array")
            return false
        }
        
        levels[index] = Level(from: newItem)
        print("item updated")
        return true
    }
    
    mutating func delete(_ item: Level) -> Bool {
        guard let index = levels.firstIndex(of: item) else { return false }
        
        levels.remove(at: index)
        return true
    }
    
    mutating func reset() {
        levels.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        reset()
        addAllSampleData()
    }
    
    mutating func addAllSampleData() {
        for item in sampleFunnels[0].levels.reversed() {
            add(item)
        }
    }
}
