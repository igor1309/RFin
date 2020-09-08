//
//  Space.swift
//  Rent
//
//  Created by Igor Malyarov on 04.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Space: Identifiable, Codable, Hashable, Equatable {
    static var noOfSpaces = 0
    
    var id = UUID()
    
    var name: String
    
    var expectedRevenue: Double
    var revenueCut: Double = 0.02
    
    var area1: Double
    var area1FixedRentRate: Double = 25
    var area1ComboRentRate: Double = 20
    
    var area2: Double
    var area2FixedRentRate: Double = 8
    var area2ComboRentRate: Double = 8
    
    var modificationDate: Date
    
    init(name: String,
         expectedRevenue: Double,
         revenueCut: Double,
         area1: Double,
         area1FixedRentRate: Double,
         area1ComboRentRate: Double,
         area2: Double,
         area2FixedRentRate: Double,
         area2ComboRentRate: Double) {
        
        Space.noOfSpaces += 1
        
        self.name = name
        self.expectedRevenue = expectedRevenue
        self.revenueCut = revenueCut
        self.area1 = area1
        self.area1FixedRentRate = area1FixedRentRate
        self.area1ComboRentRate = area1ComboRentRate
        self.area2 = area2
        self.area2FixedRentRate = area2FixedRentRate
        self.area2ComboRentRate = area2ComboRentRate
        
        self.modificationDate = Date()
    }
}

extension Space {
    init(from item: Space) {
        self.name = item.name
        self.expectedRevenue = item.expectedRevenue
        self.revenueCut = item.revenueCut
        self.area1 = item.area1
        self.area1FixedRentRate = item.area1FixedRentRate
        self.area1ComboRentRate = item.area1ComboRentRate
        self.area2 = item.area2
        self.area2FixedRentRate = item.area2FixedRentRate
        self.area2ComboRentRate = item.area2ComboRentRate
        
        self.modificationDate = Date()
    }
}

extension Space {
    var comboRent: Double {
        area1 * area1ComboRentRate + area2 * area2ComboRentRate + expectedRevenue * revenueCut
    }
    
    var fixedRent: Double {
        area1 * area1FixedRentRate + area2 * area2FixedRentRate
    }
}

extension Space {
    init(sample: Bool = false) {
        Space.noOfSpaces += 1
        
        if sample {
            name = "Metropolenhaus"
            expectedRevenue = 180_000
            area1 = 200
            area2 = 80
        } else {
            name = "New Space \(Space.noOfSpaces)"
            expectedRevenue = Double(Int.random(in: 120...200)) * 1_000
            revenueCut = Double(Int.random(in: 5...50)) / 1000
            area1 = Double(Int.random(in: 15...30)) * 10
            area2 = Double(Int.random(in: 1...9)) * 10
        }
        
        modificationDate = Date()
    }
}
