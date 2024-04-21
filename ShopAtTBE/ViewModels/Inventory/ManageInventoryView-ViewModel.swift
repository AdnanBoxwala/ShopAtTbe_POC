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
    class ViewModel {
        var isUploaded = false
        var uploadFailed = false
        
        private var database: CKDatabase
        private var container: CKContainer
        private var assetUrls: [URL] = []
        
        private(set) var items = [Product]()
        
        // MARK: Initialisation
        init() {
            let newContainer = CKContainer(identifier: "iCloud.com.github.AdnanBox.ShopAtTBE")
            self.container = newContainer
            self.database = newContainer.publicCloudDatabase
        }
        
                
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
                
        // MARK: Object methods
        func getAllItems() {
            let query = CKQuery(recordType: RecordType.product.rawValue, predicate: NSPredicate(value: true))
            
            self.database.fetch(withQuery: query) { result in
                switch result {
                case .success(let result):
                    result.matchResults.compactMap { $0.1 }
                        .forEach {
                            switch $0 {
                            case .success(let record):
                                if let fetchedRecord = Product.fromRecord(record) {
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
        
        func isCategoryEmpty(_ category: JewelleryType) -> Bool {
            self.items.filter({$0.category == category}).isEmpty
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
        
        func updateRecord(_ record: Product) {
            self.isUploaded = false
            self.uploadFailed = false
            
            self.database.fetch(withRecordID: record.recordId) { fetchedRecord, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let fetchedRecord = fetchedRecord {
                    fetchedRecord["name"] = record.name
                    fetchedRecord["price"] = record.price
                    fetchedRecord["assets"] = record.assets
                    fetchedRecord["description"] = record.description
                    fetchedRecord["productId"] = record.productId
                    fetchedRecord["quantity"] = record.quantity
                    fetchedRecord["category"] = record.category.rawValue
                    
                    self.database.save(fetchedRecord) { uploadedRecord, error in
                        if let error = error {
                            print(error.localizedDescription)
                            self.uploadFailed = true
                        } else if let _ = uploadedRecord {
                            self.items.remove(at: self.items.firstIndex(where: { $0.recordId == fetchedRecord.recordID })!)
                            self.items.append(record)
                            self.isUploaded = true
                        }
                    }
                } else { return }
            }
        }
        
        func uploadToDatabase(_ product: Product) {
            self.isUploaded = false
            self.uploadFailed = false
            
            let record = CKRecord(recordType: RecordType.product.rawValue)
            record.setValuesForKeys(product.toDictionary())
            
            // saving record in database
            self.database.save(record) { newRecord, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.uploadFailed = true
                } else {
                    if let newRecord = newRecord {
                        self.assetUrls.removeAll()
                        self.isUploaded = true
                        self.items.append(Product.fromRecord(newRecord)!)
                    }
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

