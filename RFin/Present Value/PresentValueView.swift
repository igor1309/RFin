//
//  PresentValueView.swift
//  PresentValue
//
//  Created by Igor Malyarov on 08.09.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct PresentValueView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var presentValueData: PresentValueData
    
    @State private var showModal = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Constant payments".uppercased())
                    .foregroundColor(.systemYellow)
                    .font(.caption)
                    .padding(.top)
                
                HStack {
                    Text("Payment PV")
                    Spacer()
                    Text(presentValueData.rccf.pv.formattedGrouped)
                }
                .font(.system(size: 36, weight: .semibold, design: .rounded))
                .foregroundColor(.systemYellow)
            }
            
            Text(presentValueData.rccf.explanation())
                .foregroundColor(.systemTeal)
            
            Text(presentValueData.rccf.explanation(presentValueData.multiplier))
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            if sizeClass == .compact {
                HStack {
                    Spacer()
                    
                    Button {
                        showModal = true
                    } label: {
                        Text("Change Details")
                    }
                    .padding()
                    .background(
                        Capsule()
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .padding(.top)
                    .padding(.top)
                    .sheet(isPresented: $showModal) {
                        NavigationView {
                            PresentValueDetailView()
                                .environmentObject(presentValueData)
                        }
                    }
                }
                
                Spacer()
            } else {
                PresentValueDetailView()
            }
            
        }
        .padding()
        
        .navigationBarItems(trailing: trailing)
        .navigationBarTitleDisplayMode(sizeClass == .compact ? .large : .inline)
    }
    
    @ViewBuilder
    var trailing: some View {
        if sizeClass == .compact {
            TrailingButton("Done") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct PresentValueView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PresentValueView()
        }
        .environmentObject(PresentValueData())
        .preferredColorScheme(.dark)
    }
}
