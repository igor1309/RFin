//
//  Store.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Store: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var storeWindows: [StoreWindow]
}

extension Store {
    mutating func toggleOn(_ storeWindow: StoreWindow) -> Bool {
        guard let index = storeWindows.firstIndex(of: storeWindow) else { return false }
        
        storeWindows[index].isOn.toggle()
        return true
    }
    
    mutating func delete(_ item: StoreWindow) -> Bool {
        guard let index = storeWindows.firstIndex(of: item) else { return false }
        
        storeWindows.remove(at: index)
        return true
    }
    
    
    mutating func replaceWithSampleData() {
        reset()
        addAllSampleData()
    }
    
    mutating func addAllSampleData() {
        for item in sampleStoreWindows.reversed() {
            add(item)
        }
    }
}
