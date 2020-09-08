//
//  Part.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 06.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Part: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    
    var name: String
    var abbreviation: String
    var description: String
    
    var locations: [Entry]
    
    var positions: [Entry]
}
