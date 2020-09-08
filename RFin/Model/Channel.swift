//
//  Channel.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Channel: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var funnels: [Funnel]
}

extension Channel {
    var isListEmpty: Bool { funnels.isEmpty }
    var listRunning: [Funnel] { funnels.filter { $0.isRunning } }
    var listOff: [Funnel] { funnels.filter { !$0.isRunning } }
}

extension Channel {
    func isNameUsed(_ item: Funnel) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !funnels.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return funnels.contains(where: { $0.name == item.name })
        } else {
            return funnels.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Funnel) {
        funnels.insert(Funnel(from: item), at: 0)
    }
    
    mutating func addRandom() {
        add(Funnel(random: true))
    }
    
    mutating func duplicate(_ item: Funnel) {
        var newItem = Funnel(from: item)
        var newName = item.name + " Copy"
        while funnels.map({ $0.name }).contains(newName) {
            newName += " Copy"
        }
        newItem.name = newName
        add(newItem)
    }
    
    mutating func update(_ item: Funnel, with newItem: Funnel) -> Bool {
        guard let index = funnels.firstIndex(of: item) else {
            print("can't find item in array")
            return false
        }
        
        funnels[index] = Funnel(from: newItem)
        print("item updated")
        return true
    }
    
    mutating func toggleRunning(_ connection: Funnel) -> Bool {
        guard let index = funnels.firstIndex(of: connection) else { return false }
        
        funnels[index].isRunning.toggle()
        return true
    }
    
    mutating func delete(_ item: Funnel) -> Bool {
        guard let index = funnels.firstIndex(of: item) else { return false }
        
        funnels.remove(at: index)
        return true
    }
    
    mutating func reset() {
        funnels.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        reset()
        addAllSampleData()
    }
    
    mutating func addAllSampleData() {
        for item in sampleFunnels.reversed() {
            add(item)
        }
    }
}
