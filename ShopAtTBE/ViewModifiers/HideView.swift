//
//  HideView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 10.05.24.
//

import SwiftUI

struct HideView: ViewModifier {
    let hide: Bool
    
    func body(content: Content) -> some View {
        if hide {
            
        } else {
            content
        }
    }
}

extension View {
    func hide(if condition: Bool) -> some View {
        modifier(HideView(hide: condition))
    }
}
