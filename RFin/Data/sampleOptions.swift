//
//  sampleOptions.swift
//  RFin
//
//  Created by Igor Malyarov on 17.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleOptions = [Option(investment: 600_000,
                            cashEarnings: 25_000,
                            grace: 6,
                            estPeriodInMonths: 60,
                            investorsShareBeforeReturn: 1.00,
                            investorsShareAfterReturn: 0.65),
                     Option(investment: 600_000,
                            cashEarnings: 25_000,
                            grace: 6,
                            estPeriodInMonths: 60,
                            investorsShareBeforeReturn: 0.75,
                            investorsShareAfterReturn: 0.50),
                     Option(investment: 600_000,
                            cashEarnings: 25_000,
                            grace: 6,
                            estPeriodInMonths: 60,
                            investorsShareBeforeReturn: 0.50,
                            investorsShareAfterReturn: 0.50)
]
