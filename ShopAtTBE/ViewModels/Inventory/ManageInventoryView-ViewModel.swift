//
//  AddInventoryItemViewModel.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 25.02.24.
//

import CloudKit
import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

// TODO: simplify this mess
extension ManageInventoryView {
    
    @Observable
    class FetchedRecord {
        var name: String
        var price: Double
        var assets: [CKAsset]
        var description: String
        var productId: String
        var quantity: Int
        var category: JewelleryType
        var recordId: CKRecord.ID
        
        init(name: String, price: Double, assets: [CKAsset], description: String, productId: String, quantity: Int, category: JewelleryType, recordId: CKRecord.ID) {
            self.name = name
            self.price = price
            self.assets = assets
            self.description = description
            self.productId = productId
            self.quantity = quantity
            self.category = category
            self.recordId = recordId
        }
        
        static func parseFrom(_ record: CKRecord) -> FetchedRecord? {
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
            
            return FetchedRecord(name: name, price: price, assets: assets, description: description, productId: productId, quantity: quantity, category: JewelleryType(rawValue: category) ?? .all, recordId: record.recordID)
        }
    }
    
    @Observable
    class ViewModel {
        var product = Product()
        
        private var database: CKDatabase
        private var container: CKContainer
        private var assetUrls: [URL] = []
        
        private(set) var items = [FetchedRecord]()
        private(set) var isUploading = false
        private(set) var isUploaded = false
        
//        var product = Product()
        
//        var photoPickerItems: [PhotosPickerItem] = [] {
//            didSet {
//                Task {
//                    imageData.removeAll()
//                    for item in photoPickerItems {
//                        if let data = try? await item.loadTransferable(type: Data.self) {
//                            imageData.append(data)
//                        }
//                    }
//                }
//            }
//        }
        
//        private(set) var imageData: [Data] = [] {
//            didSet {
//                Task {
//                    populateProductAssets()
//                }
//            }
//        }
                
        init() {
            let newContainer = CKContainer(identifier: "iCloud.com.github.AdnanBox.ShopAtTBE")
            self.container = newContainer
            self.database = newContainer.publicCloudDatabase
        }
        
        func uploadToDatabase(name: String, category: JewelleryType, 
                              productId: String, price: Double, quantity: Int,
                              description: String, assets: [CKAsset]) {
            isUploaded = false
            isUploading = true
            let record = CKRecord(recordType: RecordType.product.rawValue)
            
            Task {
                self.product = Product(name: name, price: price, assets: assets, description: description, productId: productId, quantity: quantity, category: category)
                record.setValuesForKeys(self.product.toDictionary())
                
                // saving record in database
                DispatchQueue.main.async {
                    self.database.save(record) { newRecord, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if let _ = newRecord {
                                self.product = Product()
                                self.assetUrls.removeAll()
                                self.isUploading = false
                                self.isUploaded = true
                            }
                        }
                    }
                }
            }
        }
        
        func updateRecord() {
            print("Update record.")
        }
        
        func removeRecord(_ recordId: CKRecord.ID) {
            self.database.delete(withRecordID: recordId) { returnedRecordId, error in
                if let error = error {
                    print("Failed to remove product with record ID \(recordId) from database with error \(error).")
                } else {
                    print("Successfully removed product with record ID \(recordId) from database.")
                }
            }
        }
        
        func isCategoryEmpty(_ category: JewelleryType) -> Bool {
            self.items.filter({$0.category == category}).isEmpty
        }
        
        func getAllItems() {
            let query = CKQuery(recordType: RecordType.product.rawValue, predicate: NSPredicate(value: true))
            
            self.database.fetch(withQuery: query) { result in
                switch result {
                case .success(let result):
                    result.matchResults.compactMap { $0.1 }
                        .forEach {
                            switch $0 {
                            case .success(let record):
                                if let fetchedRecord = FetchedRecord.parseFrom(record) {
                                    self.items.append(fetchedRecord)
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
//        private func clearAllResources() {
//            product = Product()
//            releaseImageResources()
//        }
        
//        private func populateProductAssets() {
//            product.assets.removeAll()
//            for data in imageData {
//                let temporaryURL = URL.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("dat")
//                do {
//                    try data.write(to: temporaryURL, options: [.atomic, .completeFileProtection])
//                    product.assets.append(CKAsset(fileURL: temporaryURL))
//                } catch {
//                    print(error.localizedDescription)
//                }
//                assetUrls.append(temporaryURL)
//            }
//        }
        
//        private func releaseImageResources() {
//            photoPickerItems.removeAll()
//            
//            for url in assetUrls {
//                try? FileManager.default.removeItem(at: url)
//            }
//            assetUrls.removeAll()
//        }
    }
}

