//
//  User.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 09.03.24.
//

import Foundation

@Observable
class User: Identifiable, ObservableObject {
    let id: UUID
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var emailId: String
    var role: UserRole
    
    init(id: UUID, firstName: String, lastName: String, dateOfBirth: Date, emailId: String, role: UserRole) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.emailId = emailId
        self.role = role
    }
}
