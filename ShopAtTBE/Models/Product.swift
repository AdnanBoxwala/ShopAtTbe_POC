//
//  Product.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 21.02.24.
//

import CloudKit
import UIKit
import Foundation

@Observable
class Product: Equatable, Hashable, Identifiable {
    var assets: [CKAsset]
    var category: JewelleryType
    var description: String
    var name: String
    var price: Double
    var productId: String
    var quantity: Int
    var recordId: CKRecord.ID
    
    // MARK: Initialisation
    init() {
        self.assets = []
        self.category = .ring
        self.description = ""
        self.name = ""
        self.price = 0.0
        self.productId = ""
        self.quantity = 1
        self.recordId = .init()
    }
    
    init(assets: [CKAsset], category: JewelleryType, description: String, name: String, price: Double, productId: String, quantity: Int, recordId: CKRecord.ID) {
        self.assets = assets
        self.category = category
        self.description = description
        self.name = name
        self.price = price
        self.productId = productId
        self.quantity = quantity
        self.recordId = recordId
    }
    
    // MARK: Conformance methods
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(productId)
    }
    
    // MARK: Class methods
    static func fromRecord(_ record: CKRecord) -> Product? {
        guard let assets = record.value(forKey: "assets") as? [CKAsset],
              let category = record.value(forKey: "category") as? String,
              let description = record.value(forKey: "description") as? String,
              let name = record.value(forKey: "name") as? String,
              let price = record.value(forKey: "price") as? Double,
              let productId = record.value(forKey: "productId") as? String,
              let quantity = record.value(forKey: "quantity") as? Int
        else {
            return nil
        }
        
        return Product(assets: assets,
                       category: JewelleryType(rawValue: category)!,
                       description: description,
                       name: name,
                       price: price,
                       productId: productId,
                       quantity: quantity,
                       recordId: record.recordID)
    }
    
    // MARK: Object methods
    func toDictionary() -> [String: Any] {
        return [
            "assets": assets,
            "category": category.rawValue,
            "description": description,
            "name": name,
            "price": price,
            "productId": productId,
            "quantity": quantity
        ]
    }
    
    // MARK: Computed variables
    var displayImage: UIImage? {
        return assets.first?.toUiImage()
    }
    
    var images: [UIImage] {
        var images = [UIImage]()
        for asset in assets {
            if let uiimage = asset.toUiImage() {
                images.append(uiimage)
            }
        }
        return images
    }
    
    var isEntryValid: Bool {
        return name.trimmingCharacters(in: .whitespaces).isEmpty || productId.trimmingCharacters(in: .whitespaces).isEmpty || assets.isEmpty
    }
}



extension Product {
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
    
    static let MOCK_PRODUCT = Product(assets: mockCKAssets,
                                      category: .earrings,
                                      description: "Description for Chandbali",
                                      name: "Chandbali",
                                      price: 450.0,
                                      productId: "ABCD-1234",
                                      quantity: 5,
                                      recordId: .init())
#endif
}
