//
//  MoodPopupView.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import SwiftUI

struct MoodPopupView: View {
    @ObservedObject var moodVM: MoodViewModel
    @ObservedObject var checkInVM: CheckInViewModel
    var onAllDone: () -> Void

    @State private var showCheckIn = false

    let moods = ["Happy", "Sad", "Angry", "Tired", "Sleepy", "Fine"]

    var body: some View {
        ZStack {
            // MARK: - Mood Popup
            if !showCheckIn {
                VStack(spacing: 24) {
                    Text("How are you feeling today?")
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)

                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        ForEach(moods, id: \.self) { mood in
                            MoodCell(
                                label: mood,
                                isSelected: moodVM.selectedMood == mood,
                                onTap: { moodVM.selectedMood = mood }
                            )
                        }
                    }
                    .padding(.horizontal, 8)

                    Button {
                        guard moodVM.selectedMood != nil else { return }
                        moodVM.saveMood()
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showCheckIn = true
                        }
                    } label: {
                        Text("Save")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 0.45, green: 0.60, blue: 0.35))
                            )
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
                    .opacity(moodVM.selectedMood == nil ? 0.5 : 1)
                    .disabled(moodVM.selectedMood == nil)
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.ultraThinMaterial)
                        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
                )
                .padding(.horizontal, 28)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }

            // MARK: - Check-in Popup
            if showCheckIn {
                CheckInPopupView(checkInVM: checkInVM) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        onAllDone()
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
    }
}

// MARK: - Mood Cell
struct MoodCell: View {
    let label: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                Image("head")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                isSelected
                                    ? Color(red: 0.45, green: 0.60, blue: 0.35)
                                    : Color.clear,
                                lineWidth: 3
                            )
                    )
                    .background(
                        Circle()
                            .fill(isSelected
                                  ? Color(red: 0.45, green: 0.60, blue: 0.35).opacity(0.12)
                                  : Color.clear)
                    )

                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.primary)
            }
            .padding(6)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        MoodPopupView(
            moodVM: MoodViewModel(),
            checkInVM: CheckInViewModel(),
            onAllDone: {}
        )
    }
}
