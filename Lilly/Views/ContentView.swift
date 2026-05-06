//
//  ContentView.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 03/05/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.accountTapped()
                    } label: {
                        Image(systemName: "person.circle")
                            .font(.system(size: 42))
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 24)
                .padding(.top, 55)
                
                Spacer()
                
                HStack(spacing: 30) {
                    tabButton(icon: "tree.fill", tab: .home)
                    tabButton(icon: "calendar", tab: .calendar)
                    tabButton(icon: "rosette", tab: .rewards)
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
                .padding(.bottom, 32)
            }
        }
    }
    
    func tabButton(icon: String, tab: HomeViewModel.Tab) -> some View {
        Button {
            viewModel.selectTab(tab)
        } label: {
            Image(systemName: icon)
                .font(.system(size: 21, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 54, height: 40)
                .background {
                    Capsule()
                        .fill(viewModel.selectedTab == tab ? .white.opacity(0.22) : .clear)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ContentView()
}
