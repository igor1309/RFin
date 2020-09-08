//
//  Restaurant.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    var id = UUID()
    
    var name: String
    
    var currency: Currency
    
    //var staff: Staff
    var staffVersions: StaffVersions
    
    var place: Place
    
    var channel: Channel
    
    var store: Store
    
    var network: Network
    
    var revenue: Double
    var foodcost: Double
    var labor: Double
    
    // other properties here
}

extension Restaurant {
    // computed properties for Channel/Sales Funnel
}

