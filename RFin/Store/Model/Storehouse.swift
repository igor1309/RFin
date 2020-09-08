//
//  Storehouse.swift
//  RFin
//
//  Created by Igor Malyarov on 15.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

protocol Storable {
    var id: UUID { get set }
    var name: String { get set }
    
    init()
    init(from item: Self)
    init(random: Bool)
}

extension Storable {
//    init() {
//        self.init(random: true)
//    }
    
    init(from item: Self) {
        self = item
        self.id = UUID()
    }

    init(random: Bool) {
        if random {
            self.init()
            self.name = randomString(length: 4)
        } else {
            self.init()
            self.name = "Some Item"
        }
    }
}

protocol Storehouse {
    associatedtype Element: Identifiable, Equatable, Storable
    
    var name: String { get set }
    var store: [Element] { get set }
    
    func isNameUsed(_ item: Element) -> Bool
    
    mutating func add(_ item: Element)
    mutating func addRandom()
    mutating func duplicate(_ item: Element)
    mutating func update(_ item: Element, with newItem: Element) -> Bool
    mutating func delete(_ item: Element) -> Bool
    mutating func reset()
    
    mutating func replaceWithSampleData()
    mutating func addAllSampleData()
}

extension Storehouse {
    var isStoreEmpty: Bool { store.isEmpty }
    
    func isNameUsed(_ item: Element) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !store.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")

        if isNewItem {
            return store.contains(where: { $0.name == item.name })
        } else {
            return store.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Element) {
        store.insert(Element(from: item), at: 0)
    }
    
    mutating func addRandom() {
        add(Element(random: true))
    }
    
    mutating func duplicate(_ item: Element) {
        var newItem = Element(from: item)
        var newName = item.name + " Copy"
        while store.map({ $0.name }).contains(newName) {
            newName += " Copy"
        }
        newItem.name = newName
        add(newItem)
    }
    
    mutating func update(_ item: Element, with newItem: Element) -> Bool {
        guard let index = store.firstIndex(of: item) else {
            print("can't find item in array")
            return false
        }
        
        store[index] = Element(from: newItem)
        print("item updated")
        return true
    }
    
    mutating func delete(_ item: Element) -> Bool {
        guard let index = store.firstIndex(of: item) else { return false }
        
        store.remove(at: index)
        return true
    }
    
    mutating func reset() {
        store.removeAll()
    }
}
