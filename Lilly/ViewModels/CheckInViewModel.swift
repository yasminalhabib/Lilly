//
//  CheckInViewModel.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import Foundation
import Combine

class CheckInViewModel: ObservableObject {
    @Published var checkIns: [DailyCheckIn] = []
    @Published var selectedEnergy: String? = nil
    @Published var selectedSleep: String? = nil
    @Published var selectedEating: String? = nil

    var isComplete: Bool {
        selectedEnergy != nil && selectedSleep != nil && selectedEating != nil
    }

    func saveCheckIn() {
        guard let energy = selectedEnergy,
              let sleep = selectedSleep,
              let eating = selectedEating else { return }

        let today = Calendar.current.startOfDay(for: Date())
        checkIns.removeAll {
            Calendar.current.startOfDay(for: $0.date) == today
        }
        checkIns.append(DailyCheckIn(
            date: Date(),
            energyLevel: energy,
            sleepQuality: sleep,
            eatingHabits: eating
        ))

        // Reset selections
        selectedEnergy = nil
        selectedSleep  = nil
        selectedEating = nil
    }

    func checkIn(for date: Date) -> DailyCheckIn? {
        let day = Calendar.current.startOfDay(for: date)
        return checkIns.first {
            Calendar.current.startOfDay(for: $0.date) == day
        }
    }
}
