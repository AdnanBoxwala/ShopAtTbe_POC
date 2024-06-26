//
//  AuthViewModel.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 11.03.24.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

//@MainActor
@Observable class AuthViewModel {
    var loggedInUser: FirebaseAuth.User?
    var butterflyEffectUser: User?
    
    var userRole: UserRole {
        if let butterflyEffectUser {
            return butterflyEffectUser.role
        } else {
            return .customer
        }
    }
    
    var userFetchedFromDatabase = false
    
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
            throw AuthError.failedSignIn
        }
    }
    
    func signInAsGuest() {
        Auth.auth().signInAnonymously { result, error in
            guard let result = result else {
                if let error = error {
                    print("DEBUG: Could not sign in as guest: \(error.localizedDescription)")
                }
                return
            }
            
            self.loggedInUser = result.user
            self.butterflyEffectUser = User(id: result.user.uid, firstName: "Guest", lastName: "User", dateOfBirth: .now, emailId: "", role: .customer, orderHistory: [])
        }
    }
    
    func createUser(firstName: String, lastName:String, dateOfBirth: Date, withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.loggedInUser = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, emailId: email, role: .customer, orderHistory: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
            throw AuthError.failedCreateUser
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            self.loggedInUser = nil
            self.butterflyEffectUser = nil
            self.userFetchedFromDatabase = false
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
            throw AuthError.failedSignOut
        }
    }
    
    func deleteAccount() {
        print("delete account")
    }
    
    func fetchUser() async {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {
            self.loggedInUser = nil
            return
        }
        
        do {
            self.butterflyEffectUser = try snapshot.data(as: User.self)
            self.userFetchedFromDatabase = true
        } catch {
            self.userFetchedFromDatabase = false
        }
        
        print("DEBUG: Current user is \(String(describing: self.butterflyEffectUser?.firstName)) \(String(describing: self.butterflyEffectUser?.lastName))")
    }
}

extension AuthViewModel {
    enum AuthError: Error {
        case failedSignIn
        case failedSignOut
        case failedCreateUser
        case failedGuestSignIn
    }
}
