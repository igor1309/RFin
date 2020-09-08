//
//  Venture.swift
//  RFin
//
//  Created by Igor Malyarov on 27.02.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Venture {
    let id = UUID()
    
    var name: String
    var description: String
    var partner: String
    
    /// MARK: а надо ли???
    /// ожидаемый срок возврата инвестиций в месяцах
    var periodInMonths: Int?
    
    var investment: Double
    var currency: Currency
    var investorsShareBeforeReturn: Double
    var investorsShareAfterReturn: Double
}
