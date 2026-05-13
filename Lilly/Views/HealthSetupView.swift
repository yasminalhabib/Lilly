//
//  HealthSetupView.swift
//  Lilly
//
//  Created by maha althwab on 26/11/1447 AH.
//
import SwiftUI

struct HealthSetupView: View {
    
    let onSyncHealth: () -> Void
    let onEnterManually: () -> Void
    let onSkip: () -> Void
    
    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.95, blue: 0.88)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 28) {
                
                HStack {
                    appIcon
                    
                    Spacer()
                    
                    Button("Skip for Now") {
                        onSkip()
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black.opacity(0.55))
                }
                
                Spacer()
                
                Text("Choose how you want\nto add your health data.")
                    .font(.system(size: 42, weight: .light))
                    .foregroundStyle(.black.opacity(0.65))
                    .lineSpacing(6)
                
                Text("Connect with Apple Health to sync your data automatically, or enter your information manually.")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.black.opacity(0.65))
                    .lineSpacing(4)
                
                Spacer()
                
                VStack(spacing: 16) {
                    Button {
                        onSyncHealth()
                    } label: {
                        Text("Sync with Apple Health")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                Capsule()
                                    .fill(.white.opacity(0.55))
                                    .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                            )
                            .foregroundStyle(.black.opacity(0.75))
                    }
                    
                    Button {
                        onEnterManually()
                    } label: {
                        Text("Enter Manually")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.black.opacity(0.75))
                    }
                }
            }
            .padding(.horizontal, 36)
            .padding(.top, 70)
            .padding(.bottom, 70)
        }
    }
    
    private var appIcon: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.white.opacity(0.7))
            .frame(width: 58, height: 58)
            .shadow(color: .black.opacity(0.18), radius: 8, y: 5)
            .overlay {
                Image(systemName: "heart.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.pink)
            }
    }
}

#Preview {
    HealthSetupView(
        onSyncHealth: {},
        onEnterManually: {},
        onSkip: {}
    )
}
