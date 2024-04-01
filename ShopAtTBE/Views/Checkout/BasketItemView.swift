//
//  BasketItemView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 19.03.24.
//

import SwiftUI

struct BasketItemView: View {
    var item: BasketItem
    
    var body: some View {
        HStack {
            Image(uiImage: item.displayImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 2)
                }
                .padding(.trailing)
            
            VStack {
                Text(item.name)
                Text("\(item.quantity)")
            }
             
            Spacer()
            
            Text(item.price, format: .currency(code: "AED"))
        }
    }
}

#Preview {
    BasketItemView(item: BasketItem(displayImage: UIImage(named: "Example_1")!, name: "Name", price: 150.0, productId: "ABCD-1234", quantity: 5))
}
