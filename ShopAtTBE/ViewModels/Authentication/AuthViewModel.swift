//
//  AuthViewModel.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 11.03.24.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

@Observable
class AuthViewModel {
    var loggedInUser: FirebaseAuth.User?
    var currentUser: User?
    
    init() {
        self.loggedInUser = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.loggedInUser = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(firstName: String, lastName:String, dateOfBirth: Date, withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.loggedInUser = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, emailId: email, role: .customer)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.loggedInUser = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        print("delete account")
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(String(describing: self.currentUser?.firstName)) \(String(describing: self.currentUser?.lastName))")
    }
}