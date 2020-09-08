//
//  sampleConnections.swift
//  RFin
//
//  Created by Igor Malyarov on 26.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleConnections = [Connection(name: "Open Connection",
                                    description: "Smart Protected Connection",
                                    isOn: true,
                                    ports: [Port(name: "Port 1",
                                                 description: "Port Number One",
                                                 isOn: true,
                                                 number: 9999),
                                            Port(name: "Port 2",
                                                 description: "Port Number Two",
                                                 isOn: true,
                                                 number: 7777),
                                            Port(name: "Port 3",
                                                 description: "Port Number Three",
                                                 isOn: false,
                                                 number: 4444)]),
                         Connection(name: "Closed Connection",
                                    description: "No Description for this Connection",
                                    isOn: false,
                                    ports: [])]
