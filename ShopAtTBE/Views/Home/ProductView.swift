//
//  ProductView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        VStack {
            Image("Chandbali_1")
                .resizable()
                .frame(width: 150, height: 200)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            Text("Chandbali")
                .font(.headline)
                .foregroundStyle(.black)
            Text("AED 1000.00")
                .font(.caption)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ProductView()
}
