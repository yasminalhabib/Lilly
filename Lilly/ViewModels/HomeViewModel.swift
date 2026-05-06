//
//  HomeViewModel.swift
//  Lilly
//
//  Created by maha althwab on 19/11/1447 AH.
//

import Foundation

@Observable
class HomeViewModel {
    
    var selectedTab: HomeTab = .home
    var isProfileSheetPresented = false
    
    let badges: [ProfileBadge] = [
        ProfileBadge(title: "Sleep Pro", icon: "moon.zzz.fill"),
        ProfileBadge(title: "Calm Master", icon: "sparkles"),
        ProfileBadge(title: "Energy Rush", icon: "bolt.fill"),
        ProfileBadge(title: "Hydration Hero", icon: "drop.fill")
    ]
    
    func selectTab(_ tab: HomeTab) {
        selectedTab = tab
    }
    
    func profileTapped() {
        isProfileSheetPresented = true
    }
    
    func closeProfileSheet() {
        isProfileSheetPresented = false
    }
}
