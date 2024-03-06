//
//  ShopAtTBEApp.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import SwiftUI

@main
struct ShopAtTBEApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "en_US"))
//            UpdateInventoryView()
//                .environment(\.locale, Locale(identifier: "en_US"))
        }
    }
}
