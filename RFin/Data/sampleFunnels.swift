//
//  sampleFunnels.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

typealias FunnelSlice = (name: String, period: Period, price: Double)

let funnelSlices: [FunnelSlice] = sampleFunnels.filter { $0.name != "Sample Sales Funnel" }.map { ($0.name, $0.period, $0.pricePerUnitOfTraffic) }


//https://www.quora.com/What-is-a-sales-funnel/answer/Fiona-Flintham?ch=99&share=602af963&srid=v9Y7
let sampleFunnels = [
    Funnel(name: "Sample Sales Funnel",
           description: "Sample Sales Funnel Description",
           isRunning: true,
           period: .week,
           traffic: 1_000_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 10,
           levels: [Level(name: "Awareness",
                          description: "This is where you introduce yourself. Building awareness is the first step in getting your business, brand and message in front of the right people.",
                          conversionRate: 0.05),
                    Level(name: "Engagement",
                          description: "This is the contact bit, where you build up trust and authority with the people who’ve just found out about you.",
                          conversionRate: 0.05),
                    Level(name: "Purchase",
                          description: "This is the magical moment when someone who’s found you and liked you, now takes the leap to buy from you.",
                          conversionRate: 0.05)]),
    Funnel(name: "Facebook Good",
           description: "Close to the best in Industry.",
           isRunning: true,
           period: .week,
           traffic: 100_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 9,
           levels: [Level(name: "Impression to contact",
                          description: "",
                          conversionRate: 0.01),
                    Level(name: "Contact to Sale",
                          description: "",
                          conversionRate: 0.1)]),
    Funnel(name: "Facebook Bad",
           description: "Well below average, poor performance.",
           isRunning: true,
           period: .week,
           traffic: 100_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 9,
           levels: [Level(name: "Impression to contact",
                          description: "",
                          conversionRate: 0.01),
                    Level(name: "Contact to Sale",
                          description: "",
                          conversionRate: 0.01)]),
    Funnel(name: "Facebook Targeted",
           description: "Placing with Audience Targeting.",
           isRunning: true,
           period: .week,
           traffic: 100_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 7,
           levels: [Level(name: "Impression to contact",
                          description: "",
                          conversionRate: 0.01),
                    Level(name: "Contact to Sale",
                          description: "",
                          conversionRate: 0.1)]),
    Funnel(name: "Instagram",
           description: "No description",
           isRunning: true,
           period: .week,
           traffic: 100_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 6,
           levels: [Level(name: "Impression to contact",
                          description: "",
                          conversionRate: 0.01),
                    Level(name: "Contact to Sale",
                          description: "",
                          conversionRate: 0.1)]),
    Funnel(name: "TV Ad",
           // TV @ L.A. $35 | TV @ New York City $27
           description: "No description",
           isRunning: true,
           period: .month,
           traffic: 10_000_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 30,
           levels: [Level(name: "Total Conversion",
                          description: "For simplicity 1 conversion level in the Funnel",
                          conversionRate: 0.0001)]),
    Funnel(name: "Print Ad",
           description: "Average for National Newspaper or Magazine",
           isRunning: true,
           period: .month,
           traffic: 100_000,
           unitOfTraffic: 1_000,
           pricePerUnitOfTraffic: 25,
           levels: [Level(name: "Total Conversion",
                          description: "For simplicity 1 conversion level in the Funnel",
                          conversionRate: 0.001)])
]
