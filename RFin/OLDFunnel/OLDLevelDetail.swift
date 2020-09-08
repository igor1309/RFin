//
//  OLDLevelDetail.swift
//  RFin
//
//  Created by Igor Malyarov on 25.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct OLDLevelDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @Binding var funnel: Funnel
    var level: Level
    @State private var draft: Level
    
    init(funnel: Binding<Funnel>, level: Level) {
        self._funnel = funnel
        self.level = level
        self._draft = State(initialValue: level)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("".uppercased()),
                        footer: Text("")) {
                            TextFieldWithReset("Level Name", text: $draft.name)
                            
                            TextFieldWithReset("Level Description", text: $draft.description)
                            
                            Stepper(value: $draft.conversionRate, in: 0...1, step: 0.005) {
                                HStack {
                                    Text("Conversion Rate")
                                    Spacer()
                                    Text(draft.conversionRate.formattedPercentageWith1Decimal)
                                        .foregroundColor(.systemOrange)
                                }
                            }
                }
            }
            .navigationBarTitle(draft.name)
            .navigationBarItems(trailing: TrailingButtonSFSymbol("checkmark") {
                self.save()
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
    
    func save() {
        //  MARK : TODO
    }
}

struct OLDLevelDetail_Previews: PreviewProvider {
    static var previews: some View {
        OLDLevelDetail(funnel: .constant(sampleFunnels[0]),
                    level: sampleFunnels[0].levels[0])
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
