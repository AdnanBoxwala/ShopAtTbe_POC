//
//  CustomerView-ViewModel.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 20.03.24.
//

import CloudKit
import Foundation
import SwiftUI

extension CustomerView {
    @Observable
    class ViewModel {
        struct BasketItem {
            var displayImage: UIImage
            var name: String
            var price: Double
            var productId: String
            var quantity: Int
        }
        
        private var database: CKDatabase
        private var container: CKContainer
        private(set) var items = [Product]()
        var selectedJewellery: JewelleryType = .all
        
        private(set) var basket: [BasketItem] = []
        
        init() {
            let newContainer = CKContainer(identifier: "iCloud.com.github.AdnanBox.ShopAtTBE")
            self.container = newContainer
            self.database = newContainer.publicCloudDatabase
        }
        
        func getAllItems() {
            if !items.isEmpty { return }
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
        
        func addToBasket(item: Product, quantity: Int) {
            let basketItem = BasketItem(displayImage: item.displayImage ?? UIImage(named: "placeholder_tbe")!,
                                        name: item.name,
                                        price: item.price,
                                        productId: item.productId,
                                        quantity: quantity
                            )
            
            basket.append(basketItem)
        }
    }
}
