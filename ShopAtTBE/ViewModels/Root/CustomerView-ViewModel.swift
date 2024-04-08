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
        var basket: [BasketItem] = []
        
        func addToBasket(item: Product, quantity: Int) {
            if let index = basket.firstIndex(where: {$0.productId == item.productId}) {
                basket[index].quantity += 1
            } else {
                let basketItem = BasketItem(displayImage: item.displayImage ?? UIImage(named: "placeholder_tbe")!,
                                            name: item.name,
                                            price: item.price,
                                            productId: item.productId,
                                            quantity: quantity)
                basket.append(basketItem)
            }
        }
        
        func removeBasketItem(at offsets: IndexSet) {
            let productId = basket[offsets.first!].productId
            guard let idx = basket.firstIndex(where: { $0.productId == productId }) else {
                return
            }
            basket.remove(at: idx)
        }
        
        func isValidUrlScheme(_ url: URL) -> Bool {
            guard url.scheme == "Shopattbeapp" else {
                return false
            }
            return true
        }
    }
}
