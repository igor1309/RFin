//
//  Data.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let currentRestaurantData = loadCurrentRestaurantData()

func loadCurrentRestaurantData() -> Restaurant {
    guard let data: Restaurant = loadFromDocDir("restaurant.json") else {
        return Restaurant(
            name: "Petrocelli",//"Yossi Berlin",
            
            currency: .euro,
            
            staffVersions: StaffVersions(versions: [sampleStaff]),
            
            place: Place(spaces: [Space(sample: true)]),
            
            channel: loadChannel,
            
            store: loadStore,
            
            network: loadNetwork,
            
            revenue: 180_000,
            foodcost: 44_000,
            labor: 56_000)
    }
    
    return data
}

var loadChannel: Channel {
    #if DEBUG
    return Channel(name: "Sample Funnels", funnels: sampleFunnels)
    #else
    return Channel(name: "", funnels: [])
    #endif
}

var loadNetwork: Network {
    #if DEBUG
    return Network(name: "Sample Network", connections: sampleConnections)
    #else
    return Network(name: "Noname Network", connections: [])
    #endif
}

var loadStore: Store {
    #if DEBUG
    return Store(name: "Sample Store", storeWindows: sampleStoreWindows)
    #else
    return Store(name: "Noname Store", storeWindows: [])
    #endif
}

let scenarioData = loadScenarioData()

func loadScenarioData() -> Scenario {
    guard let data: Scenario = loadFromDocDir("scenario.json") else {
        return Scenario(from: sampleQuickie.quickPLs[0])
    }
    
    return data
}

let quickieData = loadQuickieData()

func loadQuickieData() -> Quickie {
    guard let data: Quickie = loadFromDocDir("quickie.json") else {
        #if DEBUG
        return sampleQuickie
        #else
        return Quickie(quickPLs: [])
        #endif
    }
    
    return data
}

let roiData = loadROICollectionData()

func loadROICollectionData() -> ROICollection {
    guard let data: ROICollection = loadFromDocDir("roi.json") else {
        #if DEBUG
        return sampleROICollection
        #else
        return ROICollection(otbivki: [])
        #endif
    }
    
    return data
}

let sampleAnalytics = Analytics(
    restaurant: Restaurant(
        name: "Petrocelli",//"Yossi Berlin",
        
        currency: .euro,
        
        staffVersions: StaffVersions(versions: [sampleStaff]),
        
        place: Place(spaces: []),
        
        channel: Channel(name: "Sales Channels", funnels: []),
        
        store: Store(name: "Store", storeWindows: []),
        
        network: Network(name: "Noname Network", connections: []),
        
        revenue: 180_000,
        foodcost: 45_000,
        labor: 76_000))
