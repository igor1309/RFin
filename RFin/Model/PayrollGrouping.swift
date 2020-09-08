//
//  PayrollGrouping.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum PayrollGrouping: String, CaseIterable {
    case byProduct = "by Product"
    case byDivision = "by Division"
    case detailed = "Detailed"
    
    var id: String { rawValue }
}
