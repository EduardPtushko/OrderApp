//
//  Order.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
