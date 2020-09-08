//
//  CurrencySegmentedControlOLD.swift
//
//  Created by Igor Malyarov on 12.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CurrencySegmentedControl: View {
    @Binding var selection: Currency
    
    var body: some View {
        Picker("Currency", selection: $selection) {
            ForEach(Currency.allCases.filter { $0 != .none }, id: \.id) { selection in
                Text(selection.idd).tag(selection)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .labelsHidden()
    }
}

struct CurrencySegmentedControlOLD : View {
    @Binding var selection: String
    
    var body: some View {
        Picker("Currency", selection: $selection) {
            ForEach(Currency.allCases.filter { $0 != .none }, id: \.id) { selection in
                Text(selection.rawValue).tag(selection)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .labelsHidden()
    }
}

struct CurrencySegmentedControlOLDUser : View {
    @State private var selection = "$"
    
    var body: some View {
        VStack {
            Text("selection: \(selection)").font(.title)
            CurrencySegmentedControlOLD(selection: $selection)
        }
    }
}



#if DEBUG
struct CurrencySegmentedControlOLD_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                CurrencySegmentedControl(selection: .constant(Currency.euro))
                
                CurrencySegmentedControlOLD(selection: .constant("$"))
                    .previewLayout(.sizeThatFits)
                
                CurrencySegmentedControlOLD(selection: .constant("€"))
                    .previewLayout(.sizeThatFits)
                    .preferredColorScheme(.dark)
                
                CurrencySegmentedControlOLDUser()
            }
            .padding()
        }
        .environment(\.colorScheme, .dark)
    }
}
#endif
