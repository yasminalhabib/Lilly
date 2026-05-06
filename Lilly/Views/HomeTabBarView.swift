//
//  HomeTabBarView.swift
//  Lilly
//
//  Created by maha althwab on 19/11/1447 AH.
//

import SwiftUI

struct HomeTabBarView: View {
    
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(HomeTab.allCases, id: \.self) { tab in
                Button {
                    viewModel.selectTab(tab)
                } label: {
                    Image(systemName: tab.icon)
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 54, height: 40)
                        .background {
                            Capsule()
                                .fill(
                                    viewModel.selectedTab == tab
                                    ? .white.opacity(0.22)
                                    : .clear
                                )
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(.white.opacity(0.08))
                }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 32)
                .stroke(.white.opacity(0.25), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.28), radius: 22, x: 0, y: 10)
        .padding(.horizontal, 24)
    }
}
