//
//  OrderConfirmationView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 28.12.2023.
//

import SwiftUI

struct OrderConfirmationView: View {
    @Environment(\.dismiss)
    var dismiss
    var orderViewModel: OrderViewModel
    @Environment(NavigationRouter.self) var router
    @Environment(\.selected) private var selectedTab: Binding<AppScreen>

    var body: some View {
        @Bindable var router = router

        VStack {
            Text("Thank you for your order! Your wait time is approximately \(orderViewModel.minutesToPrepare) minutes.")
                .multilineTextAlignment(.center)
                .padding()

            Button {
                orderViewModel.reset()
                router.paths.removeAll()
                selectedTab.wrappedValue = .categories
                dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

#Preview {
    OrderConfirmationView(orderViewModel: OrderViewModel())
        .environment(NavigationRouter())
}
