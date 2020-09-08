//
//  PayrollRow.swift
//  Payroll
//
//  Created by Igor Malyarov on 02.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PayrollRow: View {
    @EnvironmentObject var userData: UserData
    @Binding var staff: Staff
    var position: Position
    @State private var showDetail = false
    
    var currency: Currency { userData.restaurant.currency }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                // Text(position.qty.formattedGrouped + " " + position.name + (position.qty == 1 ? "" : "s"))
                Text(position.name)
                Spacer()
                Text("\(position.qty.formattedGrouped) × \(position.hoursPerWeek.formattedGroupedWith1Decimal)")
                    + Text(" h/week").font(.caption)
            }
            .font(.headline)
            .padding(.top, 3)
            .foregroundColor(.systemOrange)
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("Hourly")
                
                Spacer()
                
                Text(currency.idd + position.payPerHourBrutto.formattedGroupedWithDecimals)
                    .foregroundColor(.systemTeal)
                
                Text(currency.idd + position.payPerHourBruttoBrutto.formattedGroupedWithDecimals)
                    .frame(minWidth: 70, alignment: .trailing)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .font(.footnote)
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("Monthly / weekly")
                
                Spacer()
                
                Text(currency.idd + position.payPerMonthBruttoBrutto.formattedGrouped)
                    .foregroundColor(.primary)
                
                Text(currency.idd + position.payPerWeekBruttoBrutto.formattedGrouped)
                    .frame(minWidth: 70, alignment: .trailing)
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            
            
            
            //            WeeklyMonthly(weeklyBrutto: position.payPerWeekBrutto,
            //                          weeklyBruttoBrutto: position.payPerWeekBruttoBrutto,
            //                          monthlyBrutto: position.payPerMonthBrutto,
            //                          monthlyBruttoBrutto: position.payPerMonthBruttoBrutto)
        }
        .contentShape(Rectangle())
        .onTapGesture { self.showDetail = true }
        
        .sheet(isPresented: $showDetail) {
            PayrollDetail(staff: self.$staff, position: self.position)
                .environmentObject(self.userData) }
    }
}

struct PayrollRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                PayrollRow(staff: .constant(sampleStaff), position: Position(name: "Cook", division: .kitchen, product: .dinner, qty: 5))
            }
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
