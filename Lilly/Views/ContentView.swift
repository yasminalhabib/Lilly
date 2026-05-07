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
        
        TabView {
            
            // HOME
            homeContent
                .tabItem {
                    Image(systemName: "tree.fill")
                    Text("Main")
                }
            
            // CALENDAR
            ZStack {
                
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                
                Text("Calendar")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            
            // BADGES
            ZStack {
                
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.35)
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
    }
    
    private var homeContent: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(0.35)
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
                
                Spacer(minLength: 160)
                
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
