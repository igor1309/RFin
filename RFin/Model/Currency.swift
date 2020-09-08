//
//  Currency.swift
//
//  Created by Igor Malyarov on 27.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

let thinSpace = "\u{2009}"
let nbsp = " \u{00a0}"  //  non-breaking space

enum Currency: String, CaseIterable, Codable, Hashable {
    case rub = "₽"
    case euro = "€"
    case usd = "$"
    case none = ""
    
    var id: String {
        return rawValue
    }
    
    var idd: String {
        return rawValue// + thinSpace
    }
}
