//
//  PresentValueData.swift
//  PresentValue
//
//  Created by Igor Malyarov on 14.02.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

final class PresentValueData: ObservableObject {
    @Published var rccf: RegularConstantCashFlow = loadRCCF() {
        didSet {
            /// `JSON`
            //  saveJSON(data: rccf, filename: "rccf.json")
            
            /// `UserDefaults`
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(rccf) {
                UserDefaults.standard.set(data, forKey: "rccf")
            }
        }
    }
    
    @Published var multiplier: Int = loadMultiplier() {
        didSet {
            UserDefaults.standard.set(multiplier, forKey: "multiplier")
        }
    }
}


func loadRCCF() -> RegularConstantCashFlow {
    /// `JSON`
    //    guard let data: RegularConstantCashFlow = loadFromDocDir("rccf.json") else {
    //        #if DEBUG
    //        return RegularConstantCashFlow.example
    //        #else
    //        return RegularConstantCashFlow.example
    //        #endif
    //    }
    //
    //    return data
    
    /// `UserDefaults`
    if let rccf = UserDefaults.standard.data(forKey: "rccf") {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(RegularConstantCashFlow.self, from: rccf) {
            return decoded
        }
    }
    
    return RegularConstantCashFlow.example
}

func loadMultiplier() -> Int {
    var multiplier = UserDefaults.standard.integer(forKey: "multiplier")
    if multiplier == 0 {
        multiplier = 1_000
    }
    
    return multiplier
}
