//
//  ROI.swift
//  Rent
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct ROICollection: Codable {
    var otbivki: [Otbivka]
}

extension ROICollection {
    mutating func add(_ item: Otbivka) {
        otbivki.insert(Otbivka(from: item), at: 0)
    }
    mutating func addRandom() {
        add(Otbivka(random: true))
    }
    mutating func update(_ item: Otbivka, with newOtbivka: Otbivka) {
        guard let index = otbivki.firstIndex(of: item) else { return }
        
        otbivki[index] = Otbivka(from: newOtbivka)
        otbivki[index].modificationDate = Date()
        otbivki.sort(by: { $0.modificationDate > $1.modificationDate
        })
    }
    mutating func delete(_ item: Otbivka) {
        guard let index = otbivki.firstIndex(of: item) else { return }

        otbivki.remove(at: index)
    }
    mutating func reset() {
        otbivki.removeAll()
    }
    mutating func replaceWithSampleData() {
        otbivki = sampleROICollection.otbivki
    }
    mutating func addAllSampleData() {
        for item in sampleROICollection.otbivki.reversed() {
            add(item)
        }
    }
}
