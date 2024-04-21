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
        var uploadSuccess = false
        var uploadFailure = false
        
        private var database: CKDatabase
        private var container: CKContainer
        
        private(set) var items = [Product]()
        
        // MARK: Initialisation
        init() {
            let newContainer = CKContainer(identifier: "iCloud.com.github.AdnanBox.ShopAtTBE")
            self.container = newContainer
            self.database = newContainer.publicCloudDatabase
        }
                
        // MARK: Object methods
        func getAllItems() {
            let query = CKQuery(recordType: RecordType.product.rawValue, predicate: NSPredicate(value: true))
            
            // fetch all records from database with defined query
            self.database.fetch(withQuery: query) { result in
                switch result {
                case .success(let result):
                    result.matchResults.compactMap { $0.1 }
                        .forEach {
                            switch $0 {
                            case .success(let record):
                                // convert CKRecord to Product
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
        
        /// Checks if items with particular category exist in the inventory.
        /// - Parameter category: type of jewellery
        /// - Returns: true, if product with type category exists in inventory
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
            self.uploadSuccess = false
            self.uploadFailure = false
            
            // fetch record from CK database of type CKRecord
            self.database.fetch(withRecordID: record.recordId) { fetchedRecord, error in
                if let error {
                    print(error.localizedDescription)
                    return
                } else if let fetchedRecord {
                    // update CKRecord details
                    fetchedRecord["name"] = record.name
                    fetchedRecord["price"] = record.price
                    fetchedRecord["assets"] = record.assets
                    fetchedRecord["description"] = record.description
                    fetchedRecord["productId"] = record.productId
                    fetchedRecord["quantity"] = record.quantity
                    fetchedRecord["category"] = record.category.rawValue
                    
                    // update record in database
                    self.database.save(fetchedRecord) { updatedRecord, error in
                        if let error {
                            print(error.localizedDescription)
                            self.uploadFailure = true
                        } else if let _ = updatedRecord {
                            // update self.items array of type [Product
                            self.items.remove(at: self.items.firstIndex(where: { $0.recordId == record.recordId })!)
                            self.items.append(record)
                            self.uploadSuccess = true
                        }
                    }
                }
            }
        }
        
        func addRecord(_ product: Product) {
            self.uploadSuccess = false
            self.uploadFailure = false
            
            let record = CKRecord(recordType: RecordType.product.rawValue)
            record.setValuesForKeys(product.toDictionary())
            
            // upload CKRecord to database
            self.database.save(record) { newRecord, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.uploadFailure = true
                } else {
                    if let newRecord = newRecord {
                        self.uploadSuccess = true
                        self.items.append(Product.fromRecord(newRecord)!)
                    }
                }
            }
        }
    }
}

