//
//  RootView.swift
//  OrderApp
//
//  Created by Eduard Ptushko on 24.12.2023.
//

import SwiftUI

struct RootView: View {
    @SceneStorage("selectedTab")
    private var selectedTab: AppScreen = .categories
    let orderViewModel = OrderViewModel()
    let navigationRouter = NavigationRouter()

    var body: some View {
        AppTabView(selection: $selectedTab)
            .environment(orderViewModel)
            .environment(navigationRouter)
            .environment(\.selected, $selectedTab)
    }
}

#Preview {
    RootView()
}

private struct SelectedKey: EnvironmentKey {
    static let defaultValue: Binding<AppScreen> = .constant(.categories)
}

extension EnvironmentValues {
    var selected: Binding<AppScreen> {
        get { self[SelectedKey.self] }
        set { self[SelectedKey.self] = newValue }
    }
}
