//
//  ProductDetailView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

struct ProductDetailView: View {
    let item: Product
    
    var body: some View {
        // TODO:
        // add everything in a vertical scrollview
        // zstack with add to bucket button on top
        VStack(alignment: .leading) {
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        // TODO: image size appear different for different produts based on resolution
                        ForEach(item.images, id: \.self) { uiimage in
                            NavigationLink {
                                // TODO:
                                // allow zoom
                                // https://www.hackingwithswift.com/quick-start/swiftui/how-to-handle-pinch-to-zoom-for-views
                                
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                            } label: {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: proxy.size.height)
                            }
                        }
                    }
                }
            }
            
            Text(item.type.rawValue)
                .font(.headline)
            Text(item.name)
                .font(.title)
            Text(item.price, format: .currency(code: "AED"))
                .font(.title3)
            
            
            Text(item.description)
            
            Spacer()
            
            Button {
                // add product to bag
            } label: {
                Text("Add to Bag")
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.secondary)
                    .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView(item: Product())
}
