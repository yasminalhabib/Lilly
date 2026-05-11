//
//  ProfileSheetView.swift
//  Lilly
//
//  Created by maha althwab on 19/11/1447 AH.
//
import SwiftUI

struct ProfileSheetView: View {
    
    let badges: [ProfileBadge]
    let onClose: () -> Void
    
    @State private var notificationsEnabled = true
    
    var body: some View {
        VStack(spacing: 24) {
            
            header
            
            badgeCollection
            
            settingsRows
            
            Spacer()
            
            Button("Close") {
                onClose()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 20)
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
    }
    
    private var header: some View {
        VStack(spacing: 12) {
            
            Image("head")
                .resizable()
                .scaledToFill()
                .frame(width: 95, height: 95)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.2), radius: 10)
            
            Text("Lilly")
                .font(.largeTitle.bold())
            
            Button("Edit") {
                print("Edit tapped")
            }
            .font(.subheadline)
            .foregroundStyle(.green)
        }
    }
    
    private var badgeCollection: some View {
        VStack(alignment: .leading, spacing: 18) {
            
            Text("🏅 Lilly's badge collection")
                .font(.headline)
            
            HStack(spacing: 18) {
                ForEach(badges) { badge in
                    
                    VStack(spacing: 8) {
                        
                        Image(systemName: badge.icon)
                            .font(.system(size: 22))
                            .frame(width: 44, height: 44)
                            .background(.green.opacity(0.15))
                            .clipShape(Circle())
                        
                        Text(badge.title)
                            .font(.caption2)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
    
    private var settingsRows: some View {
        VStack(spacing: 16) {
            
            HStack {
                
                Image(systemName: "bell.fill")
                    .foregroundStyle(.green)
                
                Text("Notifications")
                
                Spacer()
                
                Toggle("", isOn: $notificationsEnabled)
                    .labelsHidden()
                    .tint(.green) // 👈 لون التوقل الأخضر مثل أبل
            }
            .padding()
            .background(.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            
            Button {
                print("Cycle Settings tapped")
            } label: {
                
                HStack {
                    
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundStyle(.green)
                    
                    Text("Cycle Settings")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .foregroundStyle(.primary)
                .padding()
                .background(.gray.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
    }
}

#Preview {
    ProfileSheetView(
        badges: [
            ProfileBadge(title: "Sleep Pro", icon: "moon.zzz.fill"),
            ProfileBadge(title: "Calm Master", icon: "sparkles"),
            ProfileBadge(title: "Energy Rush", icon: "bolt.fill"),
            ProfileBadge(title: "Hydration Hero", icon: "drop.fill")
        ],
        onClose: {}
    )
}
