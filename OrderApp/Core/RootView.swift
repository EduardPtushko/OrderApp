//
//  RootView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct RootView: View {
    @SceneStorage("selectedTab")
    private var selectedTab = 0
    let orderViewModel = OrderViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            CategoryView()
                .tabItem {
                    Text("Menu")
                    Image(systemName: "list.bullet")
                }
                .tag(0)

            OrderView()
                .tabItem {
                    Text("Your Order")
                    Image(systemName: "bag")
                }
                .tag(1)
                .badge(orderViewModel.menuItems.count)
        }
        .environment(orderViewModel)
    }
}

#Preview {
    RootView()
}
