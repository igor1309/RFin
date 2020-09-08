//
//  Place.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Place: Codable {
    var spaces: [Space]
}

extension Place {
    var isListEmpty: Bool { spaces.isEmpty }
}

extension Place {
    mutating func add(_ item: Space) {
        spaces.insert(Space(from: item), at: 0)
    }
    
    mutating func update(_ item: Space, with newItem: Space) -> Bool {
        guard let index = spaces.firstIndex(of: item) else {
            print("can't find item in array")
            return false
        }
        
        spaces[index] = Space(from: newItem)
        spaces.sort(by: { $0.modificationDate > $1.modificationDate })
        return true
    }
    
    mutating func delete(_ item: Space) {
        guard let index = spaces.firstIndex(of: item) else { return }
        
        spaces.remove(at: index)
    }
    
    mutating func reset() {
        spaces.removeAll()
    }
}
