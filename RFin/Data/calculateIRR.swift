//
//  calculateIRR.swift
//  Otbivka
//
//  Created by Igor Malyarov on 05.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let precision = 1E-7
let maxIterations = 1000
let initialGuess = 0.05

/// The Newton - Raphson Method
func calcIRRNewtonRaphson(flows: [Double]) -> Double? {
    /// function: dicounted flows
    func fNPV(_ rate: Double) -> Double {
        var npv: Double = 0
        
        for i in 0..<flows.count {
            npv += flows[i] / pow(1 + rate, Double(i))
        }
        
        return npv
    }
    /// derivative of function
    func dfNPV(_ rate: Double) -> Double {
        var dNPV: Double = 0
        
        for i in 1..<flows.count {
            dNPV += (Double(-i) * flows[i]) / pow(1 + rate, Double(-i - 1))
        }
        
        return dNPV
    }
    func ratio(_ rate: Double) -> Double {
        fNPV(rate) / dfNPV(rate)
    }

    var rate = initialGuess
    var iteration = 1
    var r = ratio(rate)
    
    while abs(r) >= precision {
        rate = rate - r
        r = ratio(rate)
        iteration += 1
        if iteration > maxIterations {
            print("calcIRRNewtonRaphson: can't calculate IRR")
            return nil
        }
    }
    print("calcIRRNewtonRaphson: iterations: \(iteration)")
    print("calcIRRNewtonRaphson: IRR: \(rate * 100)")
    return rate
}


func calculateIRR(flows: [Double]) -> Double? {

    func fNPV(_ rate: Double) -> Double {
        var npv: Double = 0
        
        for i in flows.indices {
            npv += flows[i] / pow(1 + rate, Double(i))
        }
        
        return npv
    }
    
    var old: Double = 0.00
    var new: Double = 0.00
//    var oldguessRate: Double = -1
    var newguessRate: Double = -1
    var lowGuessRate: Double = -1
    var highGuessRate: Double = 1

    var guess: Double = initialGuess
    var npv: Double = 0
    
    for i in 0..<maxIterations {
        npv = fNPV(guess)
//        #if DEBUG
//        print("\(i): \(npv)")
//        #endif
//
        if abs(npv) < precision {
            print("calculateIRR: iterations: \(i)")
            print("calculateIRR: IRR: \(guess * 100)")
            return guess
        }
        
        if old == 0 {
            old = npv
        } else {
            old = new
        }
        new = npv
        
        if i > 0 {
            if old < new {
                if old < 0 && new < 0 {
                    highGuessRate = newguessRate
                } else {
                    lowGuessRate = newguessRate
                }
            } else {
                if old > 0 && new > 0 {
                    lowGuessRate = newguessRate
                } else {
                    highGuessRate = newguessRate
                }
            }
        }
//        oldguessRate = guess
        guess = (lowGuessRate + highGuessRate) / 2
        newguessRate = guess
    }
    
    print("calculateIRR: can't calculate IRR")
    return nil
}

