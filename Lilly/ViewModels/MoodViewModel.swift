//
//  MoodViewModel.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import Foundation
import Combine

class MoodViewModel: ObservableObject {
    @Published var entries: [MoodEntry] = []
    @Published var selectedMood: String? = nil

    func saveMood() {
        guard let mood = selectedMood else { return }
        let today = Calendar.current.startOfDay(for: Date())
        entries.removeAll {
            Calendar.current.startOfDay(for: $0.date) == today
        }
        entries.append(MoodEntry(date: Date(), mood: mood))
        selectedMood = nil
    }

    func mood(for date: Date) -> String? {
        let day = Calendar.current.startOfDay(for: date)
        return entries.first {
            Calendar.current.startOfDay(for: $0.date) == day
        }?.mood
    }
}
