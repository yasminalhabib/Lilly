//
//  ContentView.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 03/05/2026.
import SwiftUI

struct MainPageView: View {
    
    @State private var viewModel = HomeViewModel()
    
    @State private var float = false
    
    var body: some View {
        
        TabView {
            
            homeContent
                .tabItem {
                    Image(systemName: "tree.fill")
                    Text("Main")
                }
            
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                Text("Calendar")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                Text("Badges")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
            }
            .tabItem {
                Image(systemName: "rosette")
                Text("Badges")
            }
        }
        .tint(.white)
    }
    
    private var homeContent: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.profileTapped()
                    } label: {
                        Image("pro")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 24)
                .padding(.top, 85)
                
                Spacer()
                
                Image("doll")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 430, height: 430)
                    .offset(y: float ? -50 : -30)
                    .animation(
                        .easeInOut(duration: 4)
                            .repeatForever(autoreverses: true),
                        value: float
                    )
                    .padding(.bottom, -60)
                
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
                .padding(.bottom, 98)
            }
        }
        .onAppear {
            float.toggle()
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
    MainPageView()
}
