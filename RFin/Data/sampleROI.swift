//
//  sampleROI.swift
//  RFin
//
//  Created by Igor Malyarov on 14.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleROICollection = ROICollection(
    otbivki: [
        Otbivka(name: "Вай Мэ! Мытищи",
                investment: 12_000_000,
                investorsShareBeforeReturn: 0.75,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 72,
                modificationDate: Date()),
        Otbivka(name: "Вай Мэ! Щелково",
                investment: 14_000_000,
                investorsShareBeforeReturn: 0.75,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 36,
                estPeriodInMonths: 72,
                modificationDate: Date()),
        Otbivka(name: "Саперави Аминьевка",
                investment: 30_000_000,
                investorsShareBeforeReturn: 0.75,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 36,
                estPeriodInMonths: 72,
                modificationDate: Date()),
        Otbivka(name: "Аминьевка A",
                investment: 30_000_000,
                investorsShareBeforeReturn: 0.8,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 60,
                modificationDate: Date()),
        Otbivka(name: "Аминьевка B",
                investment: 30_000_000,
                investorsShareBeforeReturn: 0.75,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 60,
                modificationDate: Date()),
        Otbivka(name: "Аминьевка C",
                investment: 30_000_000,
                investorsShareBeforeReturn: 0.70,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 60,
                modificationDate: Date())
])

let sampleROICollectionYossi = ROICollection(
    otbivki: [
        Otbivka(name: "Yossi 1",
                investment: 600_000,
                investorsShareBeforeReturn: 1,
                investorsShareAfterReturn: 0.60,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 60,
                modificationDate: Date()),
        Otbivka(name: "Yossi 2",
                investment: 600_000,
                investorsShareBeforeReturn: 0.75,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 60,
                modificationDate: Date()),
        Otbivka(name: "Yossi 3",
                investment: 600_000,
                investorsShareBeforeReturn: 0.50,
                investorsShareAfterReturn: 0.50,
                monthsToReturnInvestment: 30,
                estPeriodInMonths: 60,
                modificationDate: Date())
])
