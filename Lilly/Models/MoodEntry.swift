//
//  MoodEntry.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let mood: String

    init(id: UUID = UUID(), date: Date, mood: String) {
        self.id = id
        self.date = date
        self.mood = mood
    }
}
