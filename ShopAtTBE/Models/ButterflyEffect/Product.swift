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
    let id = UUID()
    var name: String = ""
    var price: Double = 0.0
    var assets: [CKAsset] = [CKAsset]()
    var description: String = ""
    var productId: String = ""
    var quantity: Int = 1
    var category: JewelleryType = .ring
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "price": price,
            "assets": assets,
            "description": description,
            "productId": productId,
            "quantity": quantity,
            "category": category.rawValue
        ]
    }
    
    var isEntryValid: Bool {
        return name.trimmingCharacters(in: .whitespaces).isEmpty || productId.trimmingCharacters(in: .whitespaces).isEmpty || assets.isEmpty
    }
    
    static func fromRecord(_ record: CKRecord) -> Product? {
        guard let name = record.value(forKey: "name") as? String,
              let price = record.value(forKey: "price") as? Double,
              let assets = record.value(forKey: "assets") as? [CKAsset],
              let description = record.value(forKey: "description") as? String,
              let productId = record.value(forKey: "productId") as? String,
              let quantity = record.value(forKey: "quantity") as? Int,
              let category = record.value(forKey: "category") as? String
        else {
            return nil
        }
        
        return Product(name: name, price: price, assets: assets, description: description, productId: productId, quantity: quantity, category: JewelleryType(rawValue: category)!)
    }
    
    var displayImage: UIImage? {
        guard let url = assets.first?.fileURL else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return UIImage(data: data)
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
    
    #if DEBUG
    static private func createMockCKAssetForImageAsset(_ asset: String) -> CKAsset? {
        guard let uiImage = UIImage(named: asset) else {
            return nil
        }
        let fileUrl = URL.temporaryDirectory.appendingPathComponent(asset).appendingPathExtension("dat")
        if let imageData = uiImage.jpegData(compressionQuality: 1.0) {
            do {
                try imageData.write(to: fileUrl)
                let ckAsset = CKAsset(fileURL: fileUrl)
                return ckAsset
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static private let mockCKAssets: [CKAsset] = [createMockCKAssetForImageAsset("Example_1")!,
                                           createMockCKAssetForImageAsset("Example_2")!,
                                           createMockCKAssetForImageAsset("Example_3")!]
    
    static let MOCK_PRODUCT = Product(name: "Chandbali", price: 450, assets: mockCKAssets, description: "Description for Chandbali", productId: "ABCD-1234", quantity: 5, category: .earrings)
    #endif
}
