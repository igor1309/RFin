//
//  Division.swift
//  RFin
//
//  Created by Igor Malyarov on 14.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum Division: String, Codable, Hashable, CaseIterable {
    case kitchen = "Kitchen"
    case service = "Service"
    case mngt = "Mngt"
    /// co-owner or star
    case top = "Top"
    
    var id: String { rawValue }
}
