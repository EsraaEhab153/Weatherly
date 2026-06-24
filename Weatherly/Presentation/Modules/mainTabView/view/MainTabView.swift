//
//  MainTabView.swift
//  Weatherly
//
//  Created by Esraa Ehab on 24/06/2026.
//

import SwiftUI

enum Tab {
    case home
    case favorites
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .favorites:
                    SearchLocationsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 40) {
                TabBarButton(
                    icon: "house.fill",
                    title: "Home",
                    isSelected: selectedTab == .home
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = .home
                    }
                }
                
                TabBarButton(
                    icon: "star.fill",
                    title: "Favorites",
                    isSelected: selectedTab == .favorites
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = .favorites
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
            .padding(.bottom, 20) 
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
}

struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                
                if isSelected {
                    Text(title)
                        .font(.caption)
                        .bold()
                }
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .padding(.vertical, 10)
            .padding(.horizontal, isSelected ? 20 : 0)
            .background(isSelected ? Color.blue.opacity(0.15) : Color.clear)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: SavedLocations.self, inMemory: true)
}
