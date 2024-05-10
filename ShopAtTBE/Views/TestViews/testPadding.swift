//
//  testPadding.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 05.05.24.
//

import SwiftUI

struct testPadding: View {
    let columns = [GridItem(.flexible(minimum: 150, maximum: 200)), GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, content: {
                Image(.example1)
                    .resizable()
                    .scaledToFit()
            })
            
        }
        
    }
}

#Preview {
    testPadding()
}
