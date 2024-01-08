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
    var minutesToPrepare: Int = 0
    var isErrorPresent = false

    func uploadOrder() async {
        let menuIds = menuItems.map(\.id)
        do {
            let minutesToPrepare = try await MenuService.shared.postOrder(forMenuIds: menuIds)
            self.minutesToPrepare = minutesToPrepare

        } catch {
            print(error.localizedDescription)
            isErrorPresent = true
        }
    }

    func reset() {
        order.menuItems.removeAll()
        minutesToPrepare = 0
        isErrorPresent = false
    }

    func calculateTotal() -> Double {
        order.menuItems.reduce(0.0) { result, menuItem in
            result + menuItem.price
        }
    }

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
