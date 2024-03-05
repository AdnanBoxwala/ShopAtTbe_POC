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
    static let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: "AED", locale: Locale(identifier: "en_US"))
    
    var name: String = ""
    var price: Double = 0.0
    var assets: [CKAsset] = [CKAsset]()
    var description: String = ""
    var id: String = ""
    var quantity: Int = 1
    var type: JewelleryType = .ring
    
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
    
    static func fromRecord(_ record: CKRecord) -> Product? {
        guard let name = record.value(forKey: "name") as? String,
              let price = record.value(forKey: "price") as? Double,
              let assets = record.value(forKey: "assets") as? [CKAsset],
              let description = record.value(forKey: "description") as? String,
              let id = record.value(forKey: "id") as? String,
              let quantity = record.value(forKey: "quantity") as? Int,
              let type = record.value(forKey: "type") as? String
        else {
            return nil
        }
        
        return Product(name: name, price: price, assets: assets, description: description, id: id, quantity: quantity, type: JewelleryType(rawValue: type)!)
    }
}
