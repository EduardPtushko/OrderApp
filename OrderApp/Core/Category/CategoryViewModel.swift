//
//  CategoryViewModel.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 26.12.2023.
//

import Foundation

@Observable
final class CategoryViewModel {
    var categories: [String] = []
    var isErrorPresent = false

    func fetchCategories() async {
        do {
            categories = try await MenuService.shared.fetchCategories()
        } catch {
            print(error.localizedDescription)
            isErrorPresent = true
        }
    }
}
