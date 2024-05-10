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
        var bag: [CartItem] = []
        
        var totalCost: Double {
            var finalCost = 0.0
            for item in bag {
                finalCost += item.price * Double(item.quantity)
            }
            return finalCost
        }
        
        // TODO: update this value somehow
        var totalItemCount: Int {
            var totalCount = 0
            for item in bag {
                totalCount += item.quantity
            }
            return totalCount
        }
        
        func addToCart(item: Product, quantity: Int) {
            if let index = bag.firstIndex(where: {$0.productId == item.productId}) {
                bag[index].quantity += 1
            } else {
                let bagItem = CartItem(displayImage: item.displayImage ?? UIImage(named: "placeholder_tbe")!,
                                            name: item.name,
                                            price: item.price,
                                            productId: item.productId,
                                            quantity: quantity)
                bag.append(bagItem)
            }
        }
        
        func removeCartItem(at offsets: IndexSet) {
            let productId = bag[offsets.first!].productId
            guard let idx = bag.firstIndex(where: { $0.productId == productId }) else {
                return
            }
            bag.remove(at: idx)
        }
        
        func isValidUrlScheme(_ url: URL) -> Bool {
            guard url.scheme == "Shopattbeapp" else {
                return false
            }
            return true
        }
    }
}
