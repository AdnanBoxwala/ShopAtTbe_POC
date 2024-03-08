//
//  Product.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 21.02.24.
//

import CloudKit
import UIKit
import Foundation

struct Product: Identifiable {
//    Below currency formatter is still beta version
//    static let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: "AED", locale: Locale(identifier: "en_US"))
    
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AED"
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        return formatter
    }
    
    let id = UUID()
    var name: String = ""
    var price: Double = 0.0
    var assets: [CKAsset] = [CKAsset]()
    var description: String = ""
    var productId: String = ""
    var quantity: Int = 1
    var type: JewelleryType = .ring
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "price": price,
            "assets": assets,
            "description": description,
            "productId": productId,
            "quantity": quantity,
            "type": type.rawValue
        ]
    }
    
    var isEntryValid: Bool {
        return name.trimmingCharacters(in: .whitespaces).isEmpty || productId.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    static func fromRecord(_ record: CKRecord) -> Product? {
        guard let name = record.value(forKey: "name") as? String,
              let price = record.value(forKey: "price") as? Double,
              let assets = record.value(forKey: "assets") as? [CKAsset],
              let description = record.value(forKey: "description") as? String,
              let productId = record.value(forKey: "productId") as? String,
              let quantity = record.value(forKey: "quantity") as? Int,
              let type = record.value(forKey: "type") as? String
        else {
            return nil
        }
        
        return Product(name: name, price: price, assets: assets, description: description, productId: productId, quantity: quantity, type: JewelleryType(rawValue: type)!)
    }
    
    var displayImage: UIImage {
        guard let url = assets.first?.fileURL else {
            return UIImage(named: "Chandbali_1")!
        }
        guard let data = try? Data(contentsOf: url) else {
            return UIImage(named: "Chandbali_1")!
        }
        
        return UIImage(data: data)!
    }
    
    var images: [UIImage] {
        var images = [UIImage]()
        for asset in assets {
            guard let url = asset.fileURL else {
                continue
            }
            guard let data = try? Data(contentsOf: url) else {
                continue
            }
            
            images.append(UIImage(data: data)!)
        }
        return images
    }
}
