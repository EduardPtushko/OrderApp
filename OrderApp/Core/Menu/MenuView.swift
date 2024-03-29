//
//  MenuView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct MenuView: View {
    @State private var viewModel = MenuViewModel()
    let category: String

    var body: some View {
        List {
            ForEach(viewModel.menuItems) { menuItem in
                NavigationLink(value: Route.menuItem(item: menuItem)) {
                    HStack {
                        AsyncImage(url: menuItem.imageURL) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 44)
                        } placeholder: {
                            Image(systemName: "photo.on.rectangle")
                        }

                        Text(menuItem.name)
                        Spacer()
                        Text(menuItem.price.formatted(.currency(code: "usd")))
                    }
                }
            }
        }
        .navigationDestination(for: Route.self) { route in
            route.destination
        }
        .listStyle(.inset)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Failed to Fetch MenuItems", isPresented: $viewModel.isErrorPresent) {
            Button("Dismiss", role: .cancel) {}
        } message: {
            Text("Could not connect to the server.")
        }
        .task {
            await viewModel.fetchMenuItems(forCategory: category)
        }
    }
}

#Preview {
    NavigationStack {
        MenuView(category: "salads")
    }
}
