//
//  BasketItem.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 29.03.24.
//

import Foundation
import UIKit

@Observable
class BasketItem: Identifiable {
    let displayImage: UIImage
    let name: String
    let price: Double
    let productId: String
    var quantity: Int
    
    init(displayImage: UIImage, name: String, price: Double, productId: String, quantity: Int) {
        self.displayImage = displayImage
        self.name = name
        self.price = price
        self.productId = productId
        self.quantity = quantity
    }
    
#if DEBUG
    static let MOCK_ITEM: BasketItem = BasketItem(displayImage: UIImage(named: "Example_1")!, name: "Chandbali", price: 450, productId: "ABCD-1234", quantity: 5)
#endif
}


