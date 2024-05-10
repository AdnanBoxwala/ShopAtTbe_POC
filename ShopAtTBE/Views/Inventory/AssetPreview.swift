//
//  AssetPreview.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 17.04.24.
//

import CloudKit
import SwiftUI

struct AssetPreview: View {
    @State private var assets: [CKAsset]
    @State private var assetImages: [UIImage] = []
    
    init(assets: [CKAsset]) {
        self._assets = State(initialValue: assets)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<assetImages.count, id: \.self) { idx in
                    Image(uiImage: assetImages[idx])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipped()
                }
            }
        }
        .onAppear {
            Task {
                for asset in assets {
                    if let uiimage = asset.toUiImage() {
                        assetImages.append(uiimage)
                    }
                }
            }
        }
    }
}

#Preview {
    AssetPreview(assets: [])
}
