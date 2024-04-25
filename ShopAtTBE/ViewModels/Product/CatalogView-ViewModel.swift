//
//  HomeView-ViewModel.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 05.03.24.
//

import CloudKit
import Foundation
import SwiftUI

extension CatalogView {
    @Observable
    class ViewModel {
        private var database: CKDatabase
        private var container: CKContainer
        private(set) var items = [Product]()
        var selectedJewellery: JewelleryType = .all
        var sharedProduct: Product?
        
        init() {
            let newContainer = CKContainer(identifier: "iCloud.com.github.AdnanBox.ShopAtTBE")
            self.container = newContainer
            self.database = newContainer.publicCloudDatabase
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
                                    self.items.append(product)
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
        
        func handleUrl(_ url: URL) {
            guard url.scheme == "Shopattbeapp" else { return }
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                print("Invalid URL")
                return
            }
            guard let action = components.host, action == "show-product" else {
                print("Unknown URL")
                return
            }
            guard let productId = components.queryItems?.first(where: { $0.name == "productId" })?.value else {
                print("Invalid ProductId")
                return
            }
            
            let query = CKQuery(recordType: RecordType.product.rawValue, predicate: NSPredicate(format: "productId == %@", productId))
                
            self.database.fetch(withQuery: query) { result in
                switch result {
                case .success(let result):
                    switch result.matchResults.first!.1 {
                    case .success(let record):
                        if let product = Product.fromRecord(record) {
                            self.sharedProduct = product
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func showSelectedJewellery(_ item: Product) -> Bool {
            if selectedJewellery == .all { return true }
            return item.category == selectedJewellery
        }
    }
}
