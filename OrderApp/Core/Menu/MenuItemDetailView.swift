//
//  MenuItemDetailView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct MenuItemDetailView: View {
    let menuItem: MenuItem
    @Environment(OrderViewModel.self) var orderViewModel

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 260, height: 200)
                    .foregroundStyle(.blue)

                HStack {
                    Text(menuItem.name)
                    Spacer()
                    Text(menuItem.price.formatted(.currency(code: "usd")))
                }
                .padding(.top)
                Text(menuItem.detailText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()

            Button {
                orderViewModel.addToOrder(menuItem)
            } label: {
                Text("Add To Order")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 44)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .buttonStyle(.borderedProminent)
            .tint(Color(.blue))
            .phaseAnimator([true, false], trigger: orderViewModel.menuItems.count) { content, phase in
                content
                    .scaleEffect(phase ? 1 : 1.05)
            } animation: { _ in
                .bouncy(extraBounce: 0.1)
            }
        }
        .padding()
    }
}

#Preview {
    MenuItemDetailView(menuItem: MenuItem.example)
        .environment(OrderViewModel())
}
