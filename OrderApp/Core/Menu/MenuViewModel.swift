//
//  MenuViewModel.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 25.12.2023.
//

import Foundation

@Observable
final class MenuViewModel {
    var menuItems: [MenuItem] = []
    var isErrorPresent = false

    func fetchMenuItems(forCategory category: String) async {
        do {
            menuItems = try await MenuService.shared.fetchMenuItems(forCategory: category)
        } catch {
            print(error.localizedDescription)
            isErrorPresent = true
        }
    }
}
