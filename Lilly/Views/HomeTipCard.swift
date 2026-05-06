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
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
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
