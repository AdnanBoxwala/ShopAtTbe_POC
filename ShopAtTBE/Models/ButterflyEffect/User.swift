//
//  User.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import Foundation

@Observable
class ButterflyEffect {
    struct ShoppingItem: Codable {
        var name: String
        var price: Double
        var quantity: Int
        var productId: String
        var dateOfPurchase: Date
    }
    
    struct User: Identifiable, Codable {
        var id: String
        var firstName: String
        var lastName: String
        var dateOfBirth: Date
        var emailId: String
        var role: UserRole
        
        var orderHistory: [ShoppingItem]
        
        var initials: String {
            "\(firstName.first!)\(lastName.first!)"
        }
        
        init(id: String, firstName: String, lastName: String, dateOfBirth: Date, emailId: String, role: UserRole, orderHistory: [ShoppingItem]) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.dateOfBirth = dateOfBirth
            self.emailId = emailId
            self.role = role
            self.orderHistory = orderHistory
        }
    }
    
    #if DEBUG
    static let MOCK_USER = User(id: UUID().uuidString, 
                                firstName: "MOCK",
                                lastName: "USER",
                                dateOfBirth: Date(),
                                emailId: "mock.user@website.com",
                                role: .customer,
                                orderHistory: [ShoppingItem(name: Product.MOCK_PRODUCT.name,
                                                            price: Product.MOCK_PRODUCT.price,
                                                            quantity: Product.MOCK_PRODUCT.quantity,
                                                            productId: Product.MOCK_PRODUCT.productId,
                                                            dateOfPurchase: Date())])
    #endif
}
