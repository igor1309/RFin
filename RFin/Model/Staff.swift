//
//  Staff.swift
//  Staff
//
//  Created by Igor Malyarov on 02.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Staff: Codable, Hashable {
    var id = UUID()
    
    var name: String
    var positions: [Position]
}

extension Staff {
        
    var divisions: [Division] {
        positions.map({ $0.division }).removingDuplicates()
    }
    var products: [Product] {
        positions.map({ $0.product }).removingDuplicates()
    }
    var divisionList: [String] {
        positions.map({ $0.division.id }).removingDuplicates()
    }
    var productList: [String] {
        positions.map({ $0.product.id }).removingDuplicates()
    }

    func payroll(product: Product? = nil, division: Division? = nil, type: PayrollType, dividedBy: Double = 1) -> Double {
        
        var divisor = dividedBy
        if divisor == 0 { divisor = 1 }
        
        let filteredPositions = positions
            .filter { if division == nil { return true } else { return $0.division == division }}
            .filter { if product ==  nil { return true } else { return $0.product ==  product }}
        
        let hoursPerWeek =       filteredPositions.reduce(0, { $0 + $1.hoursPerWeek *           Double($1.qty) })
        let weeklyBrutto =       filteredPositions.reduce(0, { $0 + $1.payPerWeekBrutto *       Double($1.qty) })
        let weeklyBruttoBrutto = filteredPositions.reduce(0, { $0 + $1.payPerWeekBruttoBrutto * Double($1.qty) })

        let result: Double
        
        switch type {
        case .headcount:
            result = filteredPositions.reduce(0, { $0 + Double($1.qty) })
        case .hoursPerWeek:
            result = hoursPerWeek
        case .weeklyBrutto:
            result = weeklyBrutto
        case .weeklyBruttoBrutto:
            result = weeklyBruttoBrutto
        case .monthlyBrutto:
            result = filteredPositions.reduce(0, { $0 + $1.payPerMonthBrutto * Double($1.qty) })
        case .monthlyBruttoBrutto:
            result = filteredPositions.reduce(0, { $0 + $1.payPerMonthBruttoBrutto * Double($1.qty) })
        case .avgPayPerHourBrutto:
            if hoursPerWeek == 0 { result = 0 } else { result = weeklyBrutto / hoursPerWeek }
        case .avgPayPerHourBruttoBrutto:
            if hoursPerWeek == 0 { result = 0 } else { result = weeklyBruttoBrutto / hoursPerWeek }
        }
        
        return result / divisor
    }
    
        
    
    //  MARK: DELETE
    
    var headcount: Int {
        positions.reduce(0, { $0 + $1.qty })
    }
    
    var hoursPerWeek: Double {
        positions.reduce(0, { $0 + $1.hoursPerWeek * Double($1.qty) })
    }
    
    var payPerWeekBrutto: Double {
        positions.reduce(0, { $0 + $1.payPerWeekBrutto * Double($1.qty) })
    }
    
    var payPerWeekBruttoBrutto: Double {
        positions.reduce(0, { $0 + $1.payPerWeekBruttoBrutto * Double($1.qty) })
    }
    
    var payPerMonthBrutto: Double {
        positions.reduce(0, { $0 + $1.payPerMonthBrutto * Double($1.qty) })
    }
    
    var payPerMonthBruttoBrutto: Double {
        positions.reduce(0, { $0 + $1.payPerMonthBruttoBrutto * Double($1.qty) })
    }
    
    var avgPayPerHourBrutto: Double {
        if hoursPerWeek == 0 {
            return 0
        } else {
            return payPerWeekBrutto / hoursPerWeek
        }
        
    }
    
    var avgPayPerHourBruttoBrutto: Double {
        if hoursPerWeek == 0 {
            return 0
        } else {
            return payPerWeekBruttoBrutto / hoursPerWeek
        }
        
    }
}


//  MARK: CHECK AND FIX

extension Staff {
    func isNameUsed(_ item: Position) -> Bool {
        /// новый элемент еще не помещен в массив и поэтому по id не находится
        let isNewItem = !positions.contains(where: { $0.id == item.id })
        print("item is new: \(isNewItem)")
        
        if isNewItem {
            return positions.contains(where: { $0.name == item.name })
        } else {
            return positions.contains(where: { $0.name == item.name
                && $0.id != item.id
            })
        }
    }
    
    mutating func add(_ item: Position) {
        if !isNameUsed(item) {
            positions.append(Position(from: item))
        }
    }
    
    mutating func update(_ item: Position, with newItem: Position) -> Bool {
        if isNameUsed(newItem) {
            print("name is used")
            return false }
        
        if item == newItem {
            print("items are identical")
            return true }
        
        guard let index = positions.firstIndex(of: item) else {
            print("index for item not found")
            return false }
        
        positions[index] = newItem
        print("item updated successfully")
        return true
    }
    
    mutating func delete(_ item: Position) -> Bool {
        guard let index = positions.firstIndex(of: item) else { return false }
        
        positions.remove(at: index)
        return true
    }
    
    mutating func reset() {
        positions.removeAll()
    }
    
    mutating func replaceWithSampleData() {
        positions.removeAll()
        positions = samplePositions
    }
}
