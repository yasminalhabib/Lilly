//
//  DailyCheckIn.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import Foundation

struct DailyCheckIn: Identifiable, Codable {
    let id: UUID
    let date: Date
    let energyLevel: String
    let sleepQuality: String
    let eatingHabits: String

    init(id: UUID = UUID(), date: Date, energyLevel: String, sleepQuality: String, eatingHabits: String) {
        self.id = id
        self.date = date
        self.energyLevel = energyLevel
        self.sleepQuality = sleepQuality
        self.eatingHabits = eatingHabits
    }
}
