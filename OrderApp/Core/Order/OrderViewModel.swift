//
//  OrderViewModel.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 27.12.2023.
//

import Foundation

@Observable
final class OrderViewModel {
    var order = Order()

    var menuItems: [MenuItem] {
        order.menuItems
    }

    func addToOrder(_ menuItem: MenuItem) {
        order.menuItems.append(menuItem)
    }

    func removeFromOrder(_ indexSet: IndexSet) {
        order.menuItems.remove(atOffsets: indexSet)
    }
}
