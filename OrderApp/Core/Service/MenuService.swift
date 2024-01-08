//
//  MenuService.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 25.12.2023.
//

import Foundation

enum MenuError: Error {
    case categoryNotFound
    case menuItemsNotFound
    case orderRequestFailed
}

class MenuService {
    static let shared = MenuService()
    private let baseURL = URL(string: "http://localhost:8080")!

    func fetchCategories() async throws -> [String] {
        let url = baseURL.appendingPathComponent("categories")

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuError.categoryNotFound
        }

        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
        return categoriesResponse.categories
    }

    func fetchMenuItems(forCategory category: String) async throws -> [MenuItem] {
        let url = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            .init(name: "category", value: category),
        ]
        let menuUrl = components.url!

        let (data, response) = try await URLSession.shared.data(from: menuUrl)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuError.menuItemsNotFound
        }

        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)

        return menuResponse.items
    }

    typealias MinutesToPrepare = Int

    func postOrder(forMenuIds ids: [Int]) async throws -> MinutesToPrepare {
        let url = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let menuIdsDict = ["menuIds": ids]
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(menuIdsDict)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MenuError.orderRequestFailed
        }

        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)
        return orderResponse.prepTime
    }
}
