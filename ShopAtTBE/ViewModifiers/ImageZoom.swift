//
//  ImageZoom.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 28.04.24.
//

import Foundation
import SwiftUI

struct ImageZoom: ViewModifier {
    @State private var zoom = 1.0
    @State private var offset: CGSize = .zero
    
    func body(content: Content) -> some View {
        let magnifyGesture = MagnifyGesture()
            .onChanged { value in
                zoom = value.magnification > 1 ? value.magnification : 1.0
            }
//            .onEnded { _ in
//                withAnimation {
//                    zoom = 1.0
//                }
//            }
        
        let panGesture = DragGesture(minimumDistance: 0)
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                }
            }
        
        let combinedGesture = magnifyGesture.simultaneously(with: panGesture)
                
        return content
            .scaleEffect(zoom)
            .offset(offset)
            .gesture(combinedGesture)
    }
}

extension View {
    func zoomable() -> some View {
        modifier(ImageZoom())
    }
}
