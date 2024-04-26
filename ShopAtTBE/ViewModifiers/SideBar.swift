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
                    ZStack(alignment: .topTrailing) {
                        Rectangle()
                            .foregroundStyle(Color.background)
                            .frame(maxWidth: 300, maxHeight: .infinity)
                            .ignoresSafeArea()
                        
                        Button {
                            withAnimation {
                                showSideBar = false
                            }
                        } label: {
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                        }
                        .padding()
                    }
                    .overlay(alignment: .leading) {
                        sideBarContent
                    }
                    .transition(.move(edge: .leading))
                    .toolbar(.hidden, for: .navigationBar, .tabBar)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            showSideBar = true
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
    func addSideBar(with content: AnyView) -> some View {
        modifier(SideBar(sideBarContent: content))
    }
}
