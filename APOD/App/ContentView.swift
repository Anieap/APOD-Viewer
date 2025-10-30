//
//  ContentView.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    private let tabs = TabProvider.availableTabs
    
    var body: some View {
        TabView {
            ForEach(tabs, id: \.id) { tab in
                AnyView(tab.content)
                    .tabItem { tab.label }
            }
        }
    }
}

#Preview {
    ContentView()
}
