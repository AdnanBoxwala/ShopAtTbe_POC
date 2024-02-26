//
//  ProductDetailView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct ProductDetailView: View {
    let resourceNames = ["Chandbali_1", "Chandbali_2", "Chandbali_3"]
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(resourceNames, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Text("Earrings")
                .font(.headline)
            Text("Chandbali")
                .font(.title)
            Text("AED 1000.00")
                .font(.title3)
            
            
            Text("""
                 
                 These pastel blue enamel chandbali earrings are a beautiful addition to a bridal outfit. These earrings feature a traditional chandbali design with intricate detailing and delicate pearls and stones. These earrings can be paired with pastel blue or white outfits and are perfect for a daytime wedding or engagement ceremony.
                 
                 """)
            
            Spacer()
            
            Button {
                // add product to bag
            } label: {
                Text("Add to Bag")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
//        .navigationTitle("Chandbali")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView()
}
