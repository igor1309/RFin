//
//  PayrollDetail.swift
//  Payroll
//
//  Created by Igor Malyarov on 03.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PayrollDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @Binding var staff: Staff
    var position: Position
    
    @State private var draft: Position
    @State private var showAlert = false
    
    init(staff: Binding<Staff>, position: Position) {
        self._staff = staff
        self.position = position
        self._draft = State(initialValue: position)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total"),
                        footer: WeeklyMonthly(
                            weeklyBrutto:        Double(draft.qty) * draft.payPerWeekBrutto,
                            weeklyBruttoBrutto:  Double(draft.qty) * draft.payPerWeekBruttoBrutto,
                            monthlyBrutto:       Double(draft.qty) * draft.payPerMonthBrutto,
                            monthlyBruttoBrutto: Double(draft.qty) * draft.payPerMonthBruttoBrutto)
                            .padding(.bottom)
                ) {
                    Stepper(value: $draft.qty, in: 1...20, step: 1) {
                        HStack {
                            Text("Number of \(draft.name)s")
                            Spacer()
                            Text(draft.qty.formattedGrouped)
                                .foregroundColor(.systemOrange)
                        }
                    }
                }
                
                Section(header: Text("Position")) {
                    
                    Picker(selection: $draft.name,
                           label: TextField("Position Name", text: $draft.name)
                            .foregroundColor(.systemOrange)
                    ) {
                        Text("Cook").tag("Cook")
                        Text("Dish-washer").tag("Dish-washer")
                    }
                    
                    Picker(selection: $draft.division,
                           label: Text(draft.division.id)
                            .foregroundColor(.systemOrange)
                    ) {
                        ForEach(Division.allCases, id: \.self) { division in
                            Text(division.id).tag(division)
                        }
                    }
                    
                    Picker(selection: $draft.product,
                           label: Text(draft.product.id)
                            .foregroundColor(.systemOrange)
                    ) {
                        ForEach(Product.allCases, id: \.self) { product in
                            Text(product.id).tag(product)
                        }
                    }
                }
                
                Section(header: Text("Base Pay"),
                        footer: BruttoBrutto(title: "Base Hourly Rate",
                                             brutto:        draft.payPerHourBrutto,
                                             bruttoBrutto:  draft.payPerHourBruttoBrutto,
                                             hasDecimals: true)
                    
                ) {
                    PayDetail(hoursTitle: "Work hours per week",
                              hours: $draft.hoursPerWeek,
                              rateTitle: "Hourly Rate",
                              rate: $draft.payPerHourBrutto,
                              bonusTitle: "",
                              bonusRate: .constant(-1),
                              employerContributions: $draft.normalHoursTaxRate,
                              isBasePay: true)
                }
                
                Section(header: Text("Late & Night Bonus"),
                        footer:
                    VStack(alignment: .leading, spacing: 4) {
                        if draft.payPerHourBrutto != draft.totalPayPerHourBrutto {
                            BruttoBrutto(title: "Base + Bonus Hourly Rate",
                                         brutto:        draft.totalPayPerHourBrutto,
                                         bruttoBrutto:  draft.totalPayPerHourBruttoBrutto,
                                         hasDecimals: true)
                        } else {
                            EmptyView()
                        }
                }) {
                    PayDetail(hoursTitle: "Late hours per week",
                              hours: $draft.lateHoursPerWeek,
                              rateTitle: "",
                              rate: .constant(-1),
                              bonusTitle: "Late Bonus Rate",
                              bonusRate: $draft.lateHourBonusRate,
                              employerContributions: $draft.lateHoursTaxRate,
                              isBasePay: false)
                    
                    PayDetail(hoursTitle: "Night hours per week",
                              hours: $draft.nightHoursPerWeek,
                              rateTitle: "",
                              rate: .constant(-1),
                              bonusTitle: "Night Bonus Rate",
                              bonusRate: $draft.nightHourBonusRate,
                              employerContributions: $draft.nightHoursTaxRate,
                              isBasePay: false)
                }
                
                Section(header: Text("Payroll")) {
                    WeeklyMonthly(weeklyBrutto:        draft.payPerWeekBrutto,
                                  weeklyBruttoBrutto:  draft.payPerWeekBruttoBrutto,
                                  monthlyBrutto:       draft.payPerMonthBrutto,
                                  monthlyBruttoBrutto: draft.payPerMonthBruttoBrutto)
                }
                
                Section(header: Text("One way").padding(.top, 64),
                        footer: Text("Don't rush. This can not be undone.")) {
                            Button("Delete Position") {
                                self.showAlert = true
                            }
                            .foregroundColor(.systemRed)
                }
            }
            .navigationBarTitle(Text(position.name))
                //.navigationBarTitle(Text("Payroll Detail"))
                
                .navigationBarItems(trailing: TrailingButton("Done") {
                    self.save()
                    self.presentation.wrappedValue.dismiss()
                })
                
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Delete \("Position")?"),
                                message: Text("This operation couldn't be undone."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Yes, delete position")) {
                                        self.delete() }])}
        }
    }
    
    private func save() {
        if position == draft {
            print("position was not changed, nothing to save")
        } else {
            let generator = UINotificationFeedbackGenerator()
            if staff.update(position, with: draft) {
                print("ELEMENT UPDATED SUCCESSFULLY")
                generator.notificationOccurred(.success)
            } else {
                print("ERROR UPDATING ELEMENT")
                generator.notificationOccurred(.error)
            }
        }
    }
    
    private func delete() {
        //  MARK: TODO
        print("position to be deleted")
        let generator = UINotificationFeedbackGenerator()
        if staff.delete(position) {
            generator.notificationOccurred(.success)
            self.presentation.wrappedValue.dismiss()
        } else {
            generator.notificationOccurred(.error)
            print("ERROR DELETING ELEMENT")
        }
    }
}

struct PayrollDetail_Previews: PreviewProvider {
    static var previews: some View {
        PayrollDetail(staff: .constant(sampleStaff), position: sampleStaff.positions[0])
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
