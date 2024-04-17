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
extension UpdateInventoryView {
    struct CKQueriedProduct {
        var recordId: CKRecord.ID
        var product: Product
    }
    
    @Observable
    class ViewModel {
        private var database: CKDatabase
        private var container: CKContainer
        private var assetUrls: [URL] = []
        
        private(set) var items = [CKQueriedProduct]()
        private(set) var isUploading = false
        private(set) var isUploaded = false
        
        var product = Product()
        
        var photoPickerItems: [PhotosPickerItem] = [] {
            didSet {
                Task {
                    imageData.removeAll()
                    for item in photoPickerItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            imageData.append(data)
                        }
                    }
                }
            }
        }
        
        private(set) var imageData: [Data] = [] {
            didSet {
                Task {
                    populateProductAssets()
                }
            }
        }
                
        init() {
            let newContainer = CKContainer(identifier: "iCloud.com.github.AdnanBox.ShopAtTBE")
            self.container = newContainer
            self.database = newContainer.publicCloudDatabase
        }
        
        func saveToCloud() {
            isUploaded = false
            isUploading = true
            let record = CKRecord(recordType: RecordType.product.rawValue)
            record.setValuesForKeys(product.toDictionary())
            
            // saving record in database
            self.database.save(record) { newRecord, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let _ = newRecord {
                        self.isUploading = false
                        self.isUploaded = true
                        self.clearAllResources()
                    }
                }
            }
        }
        
        func remove(_ recordId: CKRecord.ID) {
            self.database.delete(withRecordID: recordId) { returnedRecordId, error in
                if let error = error {
                    print("Failed to remove product with record ID \(recordId) from database with error \(error).")
                } else {
                    print("Successfully removed product with record ID \(recordId) from database.")
                }
            }
        }
        
        func isCategoryEmpty(_ category: JewelleryType) -> Bool {
            self.items.filter({$0.product.category == category}).isEmpty
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
                                if let product = Product.fromRecord(record) {
                                    self.items.append(CKQueriedProduct(recordId: record.recordID, product: product))
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
        
        private func clearAllResources() {
            product = Product()
            releaseImageResources()
        }
        
        private func populateProductAssets() {
            product.assets.removeAll()
            for data in imageData {
                let temporaryURL = URL.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("dat")
                do {
                    try data.write(to: temporaryURL, options: [.atomic, .completeFileProtection])
                    product.assets.append(CKAsset(fileURL: temporaryURL))
                } catch {
                    print(error.localizedDescription)
                }
                assetUrls.append(temporaryURL)
            }
        }
        
        private func releaseImageResources() {
            photoPickerItems.removeAll()
            
            for url in assetUrls {
                try? FileManager.default.removeItem(at: url)
            }
            assetUrls.removeAll()
        }
    }
}

