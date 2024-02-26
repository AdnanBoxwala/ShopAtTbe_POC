//
//  Product.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 21.02.24.
//

import CloudKit
import UIKit
import Foundation

struct Product {
    enum JewelleryType: String, CaseIterable {
        case all = "All"
        case bangles = "Bangles"
        case earrings = "Earrings"
        case necklace = "Necklace"
        case ring = "Ring"
    }
    static let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: "AED", locale: Locale(identifier: "en_US"))
    
    var name: String = ""
    var price: Double = 0.0
    var assets: [CKAsset] = [CKAsset]()
    var description: String = ""
    var id: String = ""
    var quantity: Int = 1
    var type: Product.JewelleryType = .ring
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "price": price,
            "assets": assets,
            "description": description,
            "id": id,
            "quantity": quantity,
            "type": type.rawValue
        ]
    }
    
    var isEntryValid: Bool {
        return name.trimmingCharacters(in: .whitespaces).isEmpty || id.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
