//
//  UserData.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

final class UserData: ObservableObject {
    @Published var scenario: Scenario = scenarioData {
           didSet {
               // save data to local JSON
               saveJSON(data: scenario, filename: "scenario.json")
           }
       }
    
    @Published var quickie: Quickie = quickieData {
        didSet {
            // save data to local JSON
            saveJSON(data: quickie, filename: "quickie.json")
        }
    }
    
    @Published var roiCollection: ROICollection = roiData {
        didSet {
            // save data to local JSON
            saveJSON(data: roiCollection, filename: "roiCollection.json")
        }
    }
    
    @Published var restaurant: Restaurant = currentRestaurantData {
        didSet {
            // save data to local JSON
            saveJSON(data: restaurant, filename: "restaurant.json")
            print("restaurant saved")
        }
    }
}
