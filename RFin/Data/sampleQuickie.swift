//
//  sampleQuickie.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let sampleQuickie = Quickie(quickPLs: [
    QuickPL(
        investment: 30_000_000,
        depreciationPeriodForTaxation: 8,
        taxRate: 0.2,
        currency: .rub,
        
        noOfCoversPerWeek: 1000,
        coverPriceVAT: 2_700,
        
        foodcostPercentage: 0.25,
        payrollRate: 3_000_000,
        rentRate: 1_200_000,
        utilitiesPercentage: 0.017,
        booksRate: 200_000,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029),
    QuickPL(
        investment: 600_000,
        depreciationPeriodForTaxation: 7,
        taxRate: 0.3,
        currency: .euro,
        
        noOfCoversPerWeek: 720,
        coverPriceVAT: 84.5,
        
        foodcostPercentage: 0.25,
        payrollRate: 80_000,
        rentRate: 8_000,
        utilitiesPercentage: 0.017,
        booksRate: 2_200,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029),
    QuickPL(
        investment: 600_000,
        depreciationPeriodForTaxation: 7,
        taxRate: 0.3,
        currency: .euro,
        
        noOfCoversPerWeek: 600,
        coverPriceVAT: 84.5,
        
        foodcostPercentage: 0.25,
        payrollRate: 80_000,
        rentRate: 8_000,
        utilitiesPercentage: 0.017,
        booksRate: 2_200,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029),
    QuickPL(
        investment: 600_000,
        depreciationPeriodForTaxation: 7,
        taxRate: 0.3,
        currency: .euro,
        
        noOfCoversPerWeek: 490,
        coverPriceVAT: 77.5,
        
        foodcostPercentage: 0.25,
        payrollRate: 50_000,
        rentRate: 8_000,
        utilitiesPercentage: 0.017,
        booksRate: 2_200,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029),
    QuickPL(
        investment: 600_000,
        depreciationPeriodForTaxation: 7,
        taxRate: 0.3,
        currency: .euro,
        
        noOfCoversPerWeek: 490,
        coverPriceVAT: 77.5,
        
        foodcostPercentage: 0.25,
        payrollRate: 60_000,
        rentRate: 8_000,
        utilitiesPercentage: 0.017,
        booksRate: 2_200,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029),
    QuickPL(
        investment: 600_000,
        depreciationPeriodForTaxation: 7,
        taxRate: 0.3,
        currency: .euro,
        
        noOfCoversPerWeek: 700,
        coverPriceVAT: 53.50,
        
        foodcostPercentage: 0.30,
        payrollRate: 40_000,
        rentRate: 8_000,
        utilitiesPercentage: 0.017,
        booksRate: 2_200,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029),
    QuickPL(
        investment: 600_000,
        depreciationPeriodForTaxation: 7,
        taxRate: 0.3,
        currency: .euro,
        
        noOfCoversPerWeek: 480,
        coverPriceVAT: 53.50,
        
        foodcostPercentage: 0.30,
        payrollRate: 40_000,
        rentRate: 8_000,
        utilitiesPercentage: 0.017,
        booksRate: 2_200,
        marketingPercentage: 0.018,
        allOtherExpensesPercentage: 0.029)
])
