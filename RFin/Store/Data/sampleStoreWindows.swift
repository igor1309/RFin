//
//  sampleStoreWindows.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleStoreWindows = [StoreWindow(name: "Open StoreWindow",
                                    description: "Smart Protected StoreWindow",
                                    isOn: true,
                                    shelfs: [Shelf(name: "Shelf 1",
                                                 description: "Shelf Number One",
                                                 isOn: true,
                                                 number: 9999),
                                            Shelf(name: "Shelf 2",
                                                 description: "Shelf Number Two",
                                                 isOn: true,
                                                 number: 7777),
                                            Shelf(name: "Shelf 3",
                                                 description: "Shelf Number Three",
                                                 isOn: false,
                                                 number: 4444)]),
                         StoreWindow(name: "Closed StoreWindow",
                                    description: "No Description for this StoreWindow",
                                    isOn: false,
                                    shelfs: [])]
