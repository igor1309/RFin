//
//  StaffVersions.swift
//  RFin
//
//  Created by Igor Malyarov on 11.12.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct StaffVersions: Codable {
    var versions: [Staff]
    
    mutating func addEmpty() {
        duplicate(Staff(name: "New Version", positions: []))
    }
    
    mutating func addSample() {
        duplicate(sampleStaff)
    }
    
    mutating func duplicate(_ staff: Staff) {
        var newItem = staff
        
        var newName = newItem.name
        while versions.map({ $0.name }).contains(newName) {
            newName += " Copy"
        }
        newItem.name = newName

        newItem.id = UUID()
        versions.insert(newItem, at: 0)
    }
    
    mutating func delete(_ staff: Staff) {
        guard let index = versions.firstIndex(where: { $0.id == staff.id }) else { return }
        
        versions.remove(at: index)
    }
    
    mutating func rename(staff: Staff, newName: String) {
        guard let index = versions.firstIndex(where: { $0.id == staff.id }) else { return }
        
        versions[index].name = newName
    }
}
