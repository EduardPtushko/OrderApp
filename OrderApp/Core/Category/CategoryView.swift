//
//  CategoryView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct CategoryView: View {
    @State private var viewModel = CategoryViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(value: category) {
                        Text(category)
                    }
                }
            }
            .navigationDestination(for: String.self) { category in
                MenuView(category: category)
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
}
