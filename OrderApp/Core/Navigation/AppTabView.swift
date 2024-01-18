//
//  AppTabView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 18.01.2024.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen
    @Environment(OrderViewModel.self) var orderViewModel

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen)
                    .tabItem { screen.label }
                    .badge(screen == .orders ? orderViewModel.menuItems.count : 0)
            }
        }
    }
}

// #Preview {
//    AppTabView(selection: .constant(.categories))
// }
