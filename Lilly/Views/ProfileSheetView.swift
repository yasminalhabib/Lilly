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
    
    @AppStorage("notificationsEnabled") private var savedNotificationsEnabled = true
    
    @State private var notificationsEnabled = true
    @State private var isEditing = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            header
            
            badgeCollection
            
            settingsRows
            
            Spacer()
            
            Button(isEditing ? "Save" : "Close") {
                if isEditing {
                    savedNotificationsEnabled = notificationsEnabled
                    isEditing = false
                    onClose()
                } else {
                    onClose()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding(.bottom, 20)
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
        .onAppear {
            notificationsEnabled = savedNotificationsEnabled
        }
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
            
            Button(isEditing ? "Editing..." : "Edit") {
                isEditing = true
            }
            .font(.subheadline)
            .foregroundStyle(.green)
            .disabled(isEditing)
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
                    .foregroundStyle(.black)
                
                Text("Notifications")
                
                Spacer()
                
                Toggle("", isOn: $notificationsEnabled)
                    .labelsHidden()
                    .tint(.green)
                    .disabled(!isEditing)
            }
            .padding()
            .background(.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            
            Button {
                if isEditing {
                    print("Cycle Settings tapped")
                }
            } label: {
                
                HStack {
                    
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundStyle(.black)
                    
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
            .disabled(!isEditing)
            .opacity(isEditing ? 1 : 0.6)
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
