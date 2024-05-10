//
//  StepperView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 01.04.24.
//

import SwiftUI

struct StepperView: View {
    @Binding var quantity: Int
    
    var body: some View {
        HStack {
            Button {
                quantity -= 1
            } label: {
                Image(systemName: "minus")
            }
            .disabled(quantity == 0 ? true : false)
            .padding(.leading)
            
            Text("\(quantity)")
                .font(.title3)
                .padding(.horizontal)
            
            Button {
                quantity += 1
            } label: {
                Image(systemName: "plus")
            }
            .disabled(quantity == 25 ? true : false)
            .padding(.trailing)
        }
        .padding([.vertical], 5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 2)
        }
    }
}

#Preview {
    StepperView(quantity: .constant(2))
}
