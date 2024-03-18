//
//  User.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import Foundation

@Observable
class ButterflyEffect: Identifiable {
    struct ShoppingItem: Codable {
        var name: String
        var price: Double
        var quantity: Int
        var productId: String
        var dateOfPurchase: Date
    }
    
    struct User: Codable {
        var id: String
        var firstName: String
        var lastName: String
        var dateOfBirth: Date
        var emailId: String
        var role: UserRole
        
        //    TODO: add orders to user data. need to also be codable
        var orderHistory: [ShoppingItem]
        var basket: [ShoppingItem]
        
        var initials: String {
            "\(firstName.first!)\(lastName.first!)"
        }
        
        init(id: String, firstName: String, lastName: String, dateOfBirth: Date, emailId: String, role: UserRole, orderHistory: [ShoppingItem], basket: [ShoppingItem]) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.dateOfBirth = dateOfBirth
            self.emailId = emailId
            self.role = role
            self.orderHistory = orderHistory
            self.basket = basket
        }
    }
    
    var user = User(id: "", firstName: "", lastName: "", dateOfBirth: Date.now, emailId: "", role: .customer, orderHistory: [], basket: [])
}
