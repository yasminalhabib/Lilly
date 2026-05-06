//
//  HomeTab.swift
//  Lilly
//
//  Created by maha althwab on 19/11/1447 AH.
//

import Foundation

enum HomeTab: CaseIterable {
    case home
    case calendar
    case rewards
    
    var icon: String {
        switch self {
        case .home:
            return "tree.fill"
        case .calendar:
            return "calendar"
        case .rewards:
            return "rosette"
        }
    }
}
