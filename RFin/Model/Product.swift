//
//  Product.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

/// Product Line
enum Product: String, Codable, Hashable, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case brunch = "Brunch"
    case dinner = "Dinner"
    case takeaway = "Takeaway"
    case other = "Other"
    
    var id: String { rawValue }
}
