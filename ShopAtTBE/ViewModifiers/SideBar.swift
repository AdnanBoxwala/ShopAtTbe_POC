//
//  SideBar.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 25.04.24.
//

import Foundation
import SwiftUI

struct SideBar: ViewModifier {
    @State private var showSideBar = false
    var sideBarContent: AnyView
    
    func body(content: Content) -> some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                content
                    .opacity(showSideBar ? 0.2 : 1)
                    .disabled(showSideBar)
                
                if showSideBar {
                    Rectangle()
                        .foregroundStyle(Color.background)
                        .frame(maxWidth: 300, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .overlay(alignment: .leading) {
                            sideBarContent
                        }
                        .transition(.move(edge: .leading))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            showSideBar.toggle()
                        }
                    } label: {
                        Image(systemName: "sidebar.left")
                    }
                }
            }
        }
    }
}

extension View {
    func addSideBar(using content: AnyView) -> some View {
        modifier(SideBar(sideBarContent: content))
    }
}
