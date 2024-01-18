//
//  AppScreen.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 18.01.2024.
//

import SwiftUI

enum AppScreen: String, Codable, Hashable, Identifiable, CaseIterable {
    case categories
    case orders

    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .categories:
            Label("Menu", systemImage: "list.bullet")
        case .orders:
            Label("Your Order", systemImage: "bag")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .categories:
            CategoryView()
        case .orders:
            OrderView()
        }
    }
}
