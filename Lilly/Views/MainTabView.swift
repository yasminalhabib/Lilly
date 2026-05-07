//
//  MainTabView.swift
//  Lilly
//
//  Created by maha althwab on 20/11/1447 AH.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ProfileSheetView(
                badges: [
                    ProfileBadge(title: "Sleep Pro", icon: "moon.zzz.fill"),
                    ProfileBadge(title: "Calm Master", icon: "sparkles"),
                    ProfileBadge(title: "Energy Rush", icon: "bolt.fill"),
                    ProfileBadge(title: "Hydration Hero", icon: "drop.fill")
                ],
                onClose: {}
            )
            .tabItem {
                Label("Profile", systemImage: "person.circle.fill")
            }
        }
    }
}
