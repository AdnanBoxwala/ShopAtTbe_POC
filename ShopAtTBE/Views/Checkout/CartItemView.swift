//
//  CartItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 19.03.24.
//

import SwiftUI

struct CartItemView: View {
    @Bindable var item: CartItem
    @State private var showQuantitySheet = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(uiImage: item.displayImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title2)
                    Text(item.price, format: .currency(code: "AED"))
                        .font(.title3.bold())
                        .fontWeight(.bold)
                    
                    Button {
                        showQuantitySheet = true
                    } label: {
                        Text("Qty: \(item.quantity) \u{2304}")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .foregroundStyle(Color.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .sheet(isPresented: $showQuantitySheet, content: {
            VStack {
                Picker("", selection: $item.quantity) {
                    ForEach(1...10, id: \.self) { value in
                        Button("\(value)") {
                            item.quantity = value
                        }
                    }
                }
                .pickerStyle(.wheel)
                
                Button {
                    showQuantitySheet = false
                }label: {
                    Text("Done")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.primary)
                        .background(Color.secondary)
                        .clipShape(Capsule())
                }
                .padding()
            }
            .presentationDetents([.fraction(0.4)])
        })
    }
}

#Preview {
    CartItemView(item: CartItem.MOCK_ITEM)
}
