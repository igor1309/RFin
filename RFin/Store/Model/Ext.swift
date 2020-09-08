//
//  Ext.swift
//  RFin
//
//  Created by Igor Malyarov on 16.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

extension Store: Storehouse {
    var store: [StoreWindow] {
        get {
            storeWindows
        }
        set {
            storeWindows = newValue
        }
    }
}

extension StoreWindow: Storable, Storehouse {
    init() {
        self = StoreWindow(name: "StoreWindow", description: "Description", isOn: true, shelfs: [])
    }
    
    var store: [Shelf] {
        get {
            shelfs
        }
        set {
            shelfs = newValue
        }
    }
}

extension Shelf: Storable {
    init() {
        self = Shelf(name: "Shelf", description: "Description", isOn: true, number: 1)
    }
}
