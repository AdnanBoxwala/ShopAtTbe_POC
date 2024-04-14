//
//  View-Extensions.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.04.24.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            
        } else {
            self
        }
    }
}
