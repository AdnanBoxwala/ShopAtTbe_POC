//
//  ImageZoom.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 28.04.24.
//

import Foundation
import SwiftUI

struct Zoomable: ViewModifier {
    @State private var zoom = 1.0
    
    @State private var anchor: CGPoint = .zero
    @State private var contentSize: CGSize = .zero
    func magnificationPoint() -> UnitPoint {
        UnitPoint(x: self.anchor.x / self.contentSize.width, y: self.anchor.y / self.contentSize.height)
    }
            
    func body(content: Content) -> some View {
        let magnifyGesture = MagnifyGesture()
            .onChanged { value in
                anchor = value.startLocation
                zoom = value.magnification >= 1.0 ? value.magnification : 1.0
            }
            .onEnded { value in
                withAnimation {
                    zoom = 1.0
                }
            }
        
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            self.contentSize = proxy.size
                        }
                }
            }
            .scaleEffect(zoom, anchor: magnificationPoint())
            .gesture(magnifyGesture)
    }
}

extension View {
    func zoomable() -> some View {
        modifier(Zoomable())
    }
}
