//
//  ContentView.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 14.02.24.
//

import CloudKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("T.B.E", systemImage: "house") }
            CheckoutView()
                .tabItem { Label("Bag", systemImage: "handbag.fill") }
        }
    }
}

#Preview {
    ContentView()
}
