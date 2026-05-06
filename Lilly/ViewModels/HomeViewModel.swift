//
//  HomeViewModel.swift
//  Lilly
//
//  Created by maha althwab on 19/11/1447 AH.
//

import Foundation

@Observable
class HomeViewModel {
    
    enum Tab {
        case home
        case calendar
        case rewards
    }
    
    var selectedTab: Tab = .home
    
    func selectTab(_ tab: Tab) {
        selectedTab = tab
        print("Selected: \(tab)")
    }
    
    func accountTapped() {
        print("Account tapped")
    }
}
