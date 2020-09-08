//
//  Level.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

struct Level: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String = ""
    var description: String = ""
    var conversionRate: Double = 0.01
}

extension Level {
    init(from item: Level) {
        self.name = item.name
        self.description = item.description
        self.conversionRate = item.conversionRate
    }
    
    init(random: Bool) {
        if random {
            self.name = "Level " + randomString(length: 4)
            self.description = randomString(length: 32)
            self.conversionRate = Double.random(in: 0...0.3)
        } else {
            self.name = "Some Level"
            self.description = "Description for the Level"
            self.conversionRate = 0.05
        }
    }
}
