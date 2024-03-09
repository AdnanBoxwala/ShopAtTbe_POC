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

extension AddInventoryItemView {
    @Observable
    class ViewModel {
        private var database: CKDatabase
        private var container: CKContainer
        private var assetUrls: [URL] = []
        
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
                        
                        print("saved")
                    }
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

