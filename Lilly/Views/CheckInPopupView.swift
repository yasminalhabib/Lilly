//
//  CheckInPopupView.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import SwiftUI

struct CheckInPopupView: View {
    @ObservedObject var checkInVM: CheckInViewModel
    var onDone: () -> Void

    let energyOptions: [(label: String, emoji: String)] = [
        ("High",   "⚡"),
        ("Medium", "🌿"),
        ("Low",    "🌙")
    ]

    let sleepOptions: [(label: String, emoji: String)] = [
        ("Good",      "😴"),
        ("Okay",      "🌙"),
        ("Irregular", "💤")
    ]

    let eatingOptions: [(label: String, emoji: String)] = [
        ("Balanced",  "🥗"),
        ("Mixed",     "⚖️"),
        ("Indulgent", "🍔")
    ]

    var body: some View {
        VStack(spacing: 22) {

            CheckInSection(
                title: "How is your energy level?",
                options: energyOptions,
                selected: checkInVM.selectedEnergy
            ) { checkInVM.selectedEnergy = $0 }

            Divider().padding(.horizontal, 16)

            CheckInSection(
                title: "How is your sleep?",
                options: sleepOptions,
                selected: checkInVM.selectedSleep
            ) { checkInVM.selectedSleep = $0 }

            Divider().padding(.horizontal, 16)

            CheckInSection(
                title: "How would you describe your eating habits?",
                options: eatingOptions,
                selected: checkInVM.selectedEating
            ) { checkInVM.selectedEating = $0 }

            // Done button
            Button {
                checkInVM.saveCheckIn()
                onDone()
            } label: {
                Text("Done")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                checkInVM.isComplete
                                ? Color(red: 0.45, green: 0.60, blue: 0.35)
                                : Color.gray.opacity(0.4)
                            )
                    )
            }
            .disabled(!checkInVM.isComplete)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
        )
        .padding(.horizontal, 28)  // ← بس horizontal، بدون vertical
    }
}

// MARK: - Reusable Section
struct CheckInSection: View {
    let title: String
    let options: [(label: String, emoji: String)]
    let selected: String?
    let onSelect: (String) -> Void

    var body: some View {
        VStack(spacing: 14) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)

            HStack(spacing: 8) {
                ForEach(options, id: \.label) { option in
                    Button {
                        onSelect(option.label)
                    } label: {
                        HStack(spacing: 5) {
                            Text(option.label)
                                .font(.system(size: 14, weight: .medium))
                            Text(option.emoji)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(selected == option.label
                                      ? Color(red: 0.35, green: 0.50, blue: 0.28).opacity(0.25)
                                      : Color.white.opacity(0.45))
                                .overlay(
                                    Capsule()
                                        .stroke(
                                            selected == option.label
                                            ? Color(red: 0.35, green: 0.50, blue: 0.28)
                                            : Color.white.opacity(0.6),
                                            lineWidth: 1.5
                                        )
                                )
                        )
                        .foregroundColor(.primary)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        CheckInPopupView(checkInVM: CheckInViewModel()) {}
    }
}
