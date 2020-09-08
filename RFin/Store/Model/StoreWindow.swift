//
//  StoreWindow.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

struct StoreWindow: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var description: String
    var isOn: Bool
    var shelfs: [Shelf]
}

extension StoreWindow {
    mutating func toggleOn(_ shelf: Shelf) -> Bool {
        guard let index = shelfs.firstIndex(of: shelf) else { return false }
        
        shelfs[index].isOn.toggle()
        return true
    }
}

extension StoreWindow {
    mutating func replaceWithSampleData() {
        reset()
        addAllSampleData()
    }
    
    mutating func addAllSampleData() {
        for item in sampleStoreWindows[0].shelfs.reversed() {
            add(item)
        }
    }
}
