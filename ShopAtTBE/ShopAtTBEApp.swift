//
//  ShopAtTBEApp.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import Firebase
import SwiftUI

@main
struct ShopAtTBEApp: App {
    init() {
        FirebaseApp.configure()
    }
        
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
