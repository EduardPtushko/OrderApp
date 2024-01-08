//
//  OrderView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct OrderView: View {
    @Environment(OrderViewModel.self) var orderViewModel
    @State private var submitOrder = false
    @State private var showingOrderConfirmation = false

    var body: some View {
        @Bindable var orderViewModel = orderViewModel

        NavigationStack {
            List {
                ForEach(orderViewModel.menuItems) { menuItem in
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
                .onDelete(perform: { indexSet in
                    orderViewModel.removeFromOrder(indexSet)
                })
            }
            .listStyle(.inset)
            .navigationTitle("Your Order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        submitOrder.toggle()
                    } label: {
                        Text("Submit")
                    }
                    .disabled(orderViewModel.menuItems.isEmpty)
                }
            }
            .sheet(isPresented: $showingOrderConfirmation, content: {
                OrderConfirmationView(orderViewModel: orderViewModel)
            })
            .confirmationDialog("Confirm Order", isPresented: $submitOrder, titleVisibility: .visible) {
                Button {
                    Task {
                        await orderViewModel.uploadOrder()

                        guard orderViewModel.isErrorPresent == false else {
                            return
                        }
                        showingOrderConfirmation.toggle()
                    }
                } label: {
                    Text("Submit")
                }
            } message: {
                Text("You are about to submit your order with a total of \(orderViewModel.calculateTotal().formatted(.currency(code: "usd")))")
            }
            .alert("Failed to Upload Your Order", isPresented: $orderViewModel.isErrorPresent) {
                Button("Dismiss", role: .cancel) {}
            } message: {
                Text("Could not upload to the server.")
            }
        }
    }
}

#Preview {
    OrderView()
        .environment(OrderViewModel())
}
