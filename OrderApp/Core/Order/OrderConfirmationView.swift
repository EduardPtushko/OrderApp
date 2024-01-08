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

    var body: some View {
        VStack {
            Text("Thank you for your order! Your wait time is approximately \(orderViewModel.minutesToPrepare) minutes.")
                .multilineTextAlignment(.center)
                .padding()

            Button {
                orderViewModel.reset()
                dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

#Preview {
    OrderConfirmationView(orderViewModel: OrderViewModel())
}
