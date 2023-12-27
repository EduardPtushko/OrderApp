//
//  OrderView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct OrderView: View {
    @Environment(OrderViewModel.self) var orderViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(orderViewModel.menuItems) { menuItem in
                    HStack {
                        Text(menuItem.name)
                        Spacer()
                        Text(menuItem.price.formatted())
                    }
                }
                .onDelete(perform: { indexSet in
                    orderViewModel.removeFromOrder(indexSet)
                })
            }
            .navigationTitle("Your Order")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    OrderView()
        .environment(OrderViewModel())
}
