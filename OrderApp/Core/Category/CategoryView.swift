//
//  CategoryView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct CategoryView: View {
    @State private var viewModel = CategoryViewModel()
    @Environment(NavigationRouter.self) var router

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.paths) {
            List {
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(value: Route.category(item: category)) {
                        Text(category)
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                route.destination
            }
            .listStyle(.inset)
            .navigationTitle("Restaurant")
            .alert("Failed to Fetch Categories", isPresented: $viewModel.isErrorPresent) {
                Button("Dismiss", role: .cancel) {}
            } message: {
                Text("Could not connect to the server.")
            }
            .task {
                await viewModel.fetchCategories()
            }
        }
    }
}

#Preview {
    CategoryView()
        .environment(NavigationRouter())
}
