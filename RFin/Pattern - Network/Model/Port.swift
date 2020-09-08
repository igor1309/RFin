//
//  Port.swift
//  RFin
//
//  Created by Igor Malyarov on 27.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import SwiftPI

struct Port: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var description: String
    var isOn: Bool
    var number: Int
}

extension Port {
    init(from item: Port) {
        self.name = item.name
        self.description = item.description
        self.isOn = item.isOn
        self.number = item.number
    }
    
    init(random: Bool) {
        if random {
            self.name = "Port " + randomString(length: 4)
            self.description = randomString(length: 32)
            self.isOn = Bool.random()
            self.number = Int.random(in: 1_000...9_999)
        } else {
            self.name = "Some Port"
            self.description = "Description for the Port"
            self.isOn = true
            self.number = 8888
        }
    }
}
