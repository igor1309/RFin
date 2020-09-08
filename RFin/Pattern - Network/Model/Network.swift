//
//  Network.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Network: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var connections: [Connection]
}

extension Network {
    var isListEmpty: Bool { connections.isEmpty }
}

extension Network {
    func isNameUsed(_ item: Connection) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !connections.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return connections.contains(where: { $0.name == item.name })
        } else {
            return connections.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Connection) {
        connections.insert(Connection(from: item), at: 0)
    }
    
    mutating func addRandom() {
        add(Connection(random: true))
    }
    
    mutating func duplicate(_ item: Connection) {
        var newItem = Connection(from: item)
        var newName = item.name + " Copy"
        while connections.map({ $0.name }).contains(newName) {
            newName += " Copy"
        }
        newItem.name = newName
        add(newItem)
    }
    
    mutating func update(_ item: Connection, with newItem: Connection) -> Bool {
        guard let index = connections.firstIndex(of: item) else {
            print("can't find item in array")
            return false
        }
        
        connections[index] = Connection(from: newItem)
        print("item updated")
        return true
    }
    
    mutating func toggleOn(_ connection: Connection) -> Bool {
        guard let index = connections.firstIndex(of: connection) else { return false }
        
        connections[index].isOn.toggle()
        return true
    }
    
    mutating func delete(_ item: Connection) -> Bool {
        guard let index = connections.firstIndex(of: item) else { return false }
        
        connections.remove(at: index)
        return true
    }
    
    mutating func reset() {
        connections.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        reset()
        addAllSampleData()
    }
    
    mutating func addAllSampleData() {
        for item in sampleConnections.reversed() {
            add(item)
        }
    }
}
