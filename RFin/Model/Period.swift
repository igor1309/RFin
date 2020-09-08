//
//  Periods.swift
//
//  Created by Igor Malyarov on 29.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

enum Period: String, CaseIterable, Codable, Hashable {
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
    
    var id: String { rawValue }
}
