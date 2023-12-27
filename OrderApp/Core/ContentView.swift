//
//  ContentView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct ContentView: View {
    let orderViewModel = OrderViewModel()

    var body: some View {
        TabView {
            CategoryView()
                .tabItem {
                    Text("Menu")
                    Image(systemName: "list.bullet")
                }

            OrderView()
                .tabItem {
                    Text("Your Order")
                    Image(systemName: "bag")
                }
                .badge(orderViewModel.menuItems.count)
        }
        .environment(orderViewModel)
    }
}

#Preview {
    ContentView()
}
