//
//  HomeTipCard.swift
//  Lilly
//
//  Created by maha althwab on 19/11/1447 AH.
//
import SwiftUI

struct HomeTipCard: View {
    
    let tip: HomeTip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(tip.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.limeGreen)
            
            Text(tip.subtitle)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            Text(tip.description)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(20)
        .frame(width: 190, height: 170)
        
        .background(
            ZStack {
                
                // القزاز
                RoundedRectangle(cornerRadius: 32)
                    .fill(.ultraThinMaterial)
                    .opacity(0.75)
                
                // لمعة خفيفة
                RoundedRectangle(cornerRadius: 32)
                    .fill(
                        LinearGradient(
                            colors: [
                                .white.opacity(0.20),
                                .clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        )
        
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(
                    .white.opacity(0.25),
                    lineWidth: 1
                )
        )
        
        .shadow(
            color: .black.opacity(0.12),
            radius: 15,
            x: 0,
            y: 10
        )
    }
}

extension Color {
    static let limeGreen = Color(
        red: 0.78,
        green: 1.0,
        blue: 0.18
    )
}
