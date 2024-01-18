//
//  NavigationRouter.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 18.01.2024.
//

import SwiftUI

@Observable
final class NavigationRouter {
    var paths: [Route] = []
}

enum Route: Hashable {
    case category(item: String)
    case menuItem(item: MenuItem)
}

extension Route {
    @ViewBuilder
    var destination: some View {
        switch self {
        case .category(let item):
            MenuView(category: item)
        case .menuItem(item: let item):
            MenuItemDetailView(menuItem: item)
        }
    }
}
