//
//  User.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var emailId: String
    var role: UserRole
    
//    TODO: add orders to user data. need to also be codable
//    var orders: [Product] = []
    
    init(id: String, firstName: String, lastName: String, dateOfBirth: Date, emailId: String, role: UserRole) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.emailId = emailId
        self.role = role
    }
    
    var initials: String {
        "\(firstName.first!)\(lastName.first!)"
    }
}
