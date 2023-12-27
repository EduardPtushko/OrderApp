//
//  MenuItem.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import Foundation

struct MenuItem: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}

extension MenuItem {
    static let example = MenuItem(
        id: 1,
        name: "Spaghetti and Meatballs",
        detailText: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.",
        price: 9.0,
        category: "entrees",
        imageURL: URL(
            string: "https://picsum.photos/200/300"
        )!
    )
}
