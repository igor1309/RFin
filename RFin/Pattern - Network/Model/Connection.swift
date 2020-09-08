//
//  Connection.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

struct Connection: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var description: String
    var isOn: Bool
    var ports: [Port]
}

extension Connection {
    init(from item: Connection) {
        self.name = item.name
        self.description = item.description
        self.isOn = item.isOn
        self.ports = item.ports
    }
    
    init(random: Bool) {
        if random {
            self.name = "Connection " + randomString(length: 4)
            self.description = randomString(length: 32)
            self.isOn = Bool.random()
            self.ports = [Port(random: true)]
        } else {
            self.name = "Some Connection"
            self.description = "Description for the Connection"
            self.isOn = true
            self.ports = [Port(random: false)]
        }
    }
}

extension Connection {
    var isListEmpty: Bool { ports.isEmpty }
}

extension Connection {
    func isNameUsed(_ item: Port) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !ports.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return ports.contains(where: { $0.name == item.name })
        } else {
            return ports.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Port) {
        ports.insert(Port(from: item), at: 0)
    }
    
    mutating func addRandom() {
        add(Port(random: true))
    }
    
    mutating func duplicate(_ item: Port) {
        var newItem = Port(from: item)
        var newName = item.name + " Copy"
        while ports.map({ $0.name }).contains(newName) {
            newName += " Copy"
        }
        newItem.name = newName
        add(newItem)
    }
    
    mutating func update(_ item: Port, with newItem: Port) -> Bool {
        guard let index = ports.firstIndex(of: item) else {
            print("can't find item in array")
            return false
        }
        
        ports[index] = Port(from: newItem)
        print("item updated")
        return true
    }
    
    mutating func toggleOn(_ connection: Port) -> Bool {
        guard let index = ports.firstIndex(of: connection) else { return false }
        
        ports[index].isOn.toggle()
        return true
    }
    
    mutating func delete(_ item: Port) -> Bool {
        guard let index = ports.firstIndex(of: item) else { return false }
        
        ports.remove(at: index)
        return true
    }
    
    mutating func reset() {
        ports.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        reset()
        addAllSampleData()
    }
    
    mutating func addAllSampleData() {
        for item in sampleConnections[0].ports.reversed() {
            add(item)
        }
    }
}
