//
//  ContentView.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 03/05/2026.
//
import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = HomeViewModel()
    
    // حركة الشخصية
    @State private var float = false
    
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
            
            // BADGES
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
            
            // الخلفية
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                // زر البروفايل
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
                .padding(.top, 85)
                
                Spacer()
                
                // الشخصية
                Image("doll")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 430, height: 430)
                    
                    // حركة الطيران
                    .offset(y: float ? -50 : -30)
                    
                    // انيميشن
                    .animation(
                        .easeInOut(duration: 4)
                            .repeatForever(autoreverses: true),
                        value: float
                    )
                    
                    // حتى ما تدف الكروت
                    .padding(.bottom, -60)
                
                // قسم النصائح
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
        
        // تشغيل الانيميشن
        .onAppear {
            float.toggle()
        }
        
        // شيت البروفايل
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
