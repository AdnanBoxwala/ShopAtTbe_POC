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
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            Text(name)
                .font(.headline)
                .foregroundStyle(Color.primary)
            Text(price.formatted(.currency(code: "AED")))
                .font(.caption)
                .foregroundStyle(Color.primary)
        }
    }
}

#Preview {
    ProductView(image: UIImage(named: "Chandbali_1")!, name: "test", price: 100.0)
}
