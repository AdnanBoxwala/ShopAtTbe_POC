//
//  Home.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 04.05.24.
//

import SwiftUI

struct ScrollableTabBar<Content, T: RawRepresentable & CaseIterable & Hashable & Identifiable>: View where Content: View, T.AllCases: RandomAccessCollection, T.RawValue == String {
    @State var activeTab: T
    @State private var tabBarScrollState: T?
    @State private var mainViewScrollState: T?
    var content: (T) -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            CustomTabbar()
            
            GeometryReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(T.allCases) { type in
                            content(type)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .padding(.top)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .onChange(of: mainViewScrollState) { oldValue, newValue in
                    if let newValue {
                        withAnimation {
                            tabBarScrollState = newValue
                            activeTab = newValue
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomTabbar() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(T.allCases) { type in
                    Button(action: {
                        withAnimation {
                            activeTab = type
                            tabBarScrollState = type
                            mainViewScrollState = type
                        }
                    }) {
                        Text(type.rawValue)
                            .padding(.vertical, 12)
                            .foregroundStyle(activeTab == type ? Color.primary : .gray)
                            .contentShape(.rect)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $tabBarScrollState, anchor: .center)
        .safeAreaPadding(.horizontal, 15)
        .overlay(alignment: .bottom, content: {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .frame(height: 1)
            }
        })
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ScrollableTabBar(activeTab: JewelleryType.bangles) { type in
        ScrollView(.vertical) {
            Text(type.rawValue)
        }
    }
}
