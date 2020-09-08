//
//  SettingsStore.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 08.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation
import CoreHaptics


// MARK: DELETE??
var hapticsAvailable: Bool { CHHapticEngine.capabilitiesForHardware().supportsHaptics }

final class SettingsStore: ObservableObject {
    private let defaults = UserDefaults.standard
    
    @Published var selectedPayrollType = PayrollType(rawValue: UserDefaults.standard.string(forKey: "selectedPayrollType") ?? PayrollType.avgPayPerHourBruttoBrutto.rawValue) ?? PayrollType.avgPayPerHourBruttoBrutto {
        didSet {
            defaults.set(selectedPayrollType.id, forKey: "selectedPayrollType")
        }
    }
    
    @Published var selectedPayrollGrouping = PayrollGrouping(rawValue: UserDefaults.standard.string(forKey: "selectedPayrollGrouping") ?? PayrollGrouping.detailed.rawValue) ?? PayrollGrouping.detailed {
        didSet {
            defaults.set(selectedPayrollGrouping.id, forKey: "selectedPayrollGrouping")
        }
    }
    
    @Published var irrThreshhold: Double = UserDefaults.standard.double(forKey: "irrThreshhold") {
        didSet {
            defaults.set(irrThreshhold, forKey: "irrThreshhold")
        }
    }
    
    @Published var showPerYear: Bool = UserDefaults.standard.bool(forKey: "showPerYear") {
        didSet {
            defaults.set(showPerYear, forKey: "showPerYear")
        }
    }
        
    @Published var investmentReturnPeriodThreshhold: Int = UserDefaults.standard.integer(forKey: "investmentReturnPeriodThreshhold") {
        didSet {
            defaults.set(investmentReturnPeriodThreshhold, forKey: "investmentReturnPeriodThreshhold")
        }
    }
    
    @Published var seatingGuideArea: Double = UserDefaults.standard.double(forKey: "seatingGuideArea") {
        didSet {
            defaults.set(seatingGuideArea, forKey: "seatingGuideArea")
        }
    }
    
    @Published var isKitchenIncludedSeating: Bool = UserDefaults.standard.bool(forKey: "isKitchenIncludedSeating") {
        didSet {
            defaults.set(isKitchenIncludedSeating, forKey: "isKitchenIncludedSeating")
        }
    }
        
    @Published var selectedBenchmarkFilter: Int = UserDefaults.standard.integer(forKey: "selectedBenchmarkFilter") {
        didSet {
            defaults.set(selectedBenchmarkFilter, forKey: "selectedBenchmarkFilter")
        }
    }
    
    @Published var editingIsAllowed: Bool = UserDefaults.standard.bool(forKey: "editingIsAllowed") {
        didSet {
            defaults.set(editingIsAllowed, forKey: "editingIsAllowed")
        }
    }
    
    @Published var selectedTab: Int = UserDefaults.standard.integer(forKey: "selectedTab") {
        didSet {
            defaults.set(selectedTab, forKey: "selectedTab")
        }
    }
}
