//
//  ProductView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import CloudKit
import SwiftUI

struct ProductView: View {
    let image: UIImage
    let name: String
    let price: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                
            VStack(alignment: .leading) {
                Text(name)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Text(price.formatted(.currency(code: "AED")))
                    .font(.subheadline).bold()
                    .foregroundStyle(Color.primary)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProductView(image: UIImage(named: "Example_1")!, name: "test", price: 100.0)
}
