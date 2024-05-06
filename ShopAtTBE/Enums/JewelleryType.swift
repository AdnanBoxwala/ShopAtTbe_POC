//
//  JewelleryType.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 05.03.24.
//

import Foundation

enum JewelleryType: String, CaseIterable, Hashable, Identifiable {
    case bangles = "Bangles"
    case earrings = "Earrings"
    case necklaces = "Necklaces"
    case rings = "Rings"
    
    var id: Self {
        return self
    }
}
