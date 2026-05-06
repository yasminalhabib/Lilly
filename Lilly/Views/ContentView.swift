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
            Color.black
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.profileTapped()
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
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("Today’s Tips")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.tips) { tip in
                                HomeTipCard(tip: tip)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(.bottom, 28)
                
                HomeTabBarView(viewModel: viewModel)
                    .padding(.bottom, 32)
            }
        }
        .sheet(isPresented: $viewModel.isProfileSheetPresented) {
            ProfileSheetView(
                badges: viewModel.badges,
                onClose: {
                    viewModel.closeProfileSheet()
                }
            )
            .presentationDetents([.fraction(0.85)])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
}
