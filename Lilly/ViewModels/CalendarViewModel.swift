//
//  CalendarViewModel.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var selectedWeek: Int = 1
    @Published var selectedDate: Date? = nil

    let weekdays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

    var currentMonthIndex: Int {
        Calendar.current.component(.month, from: currentMonth) - 1
    }

    var currentYear: Int {
        Calendar.current.component(.year, from: currentMonth)
    }

    var currentMonthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentMonth)
    }

    var daysInGrid: [Date?] {
        let cal = Calendar.current
        guard let monthStart = cal.date(
            from: cal.dateComponents([.year, .month], from: currentMonth)
        ) else { return [] }

        let firstWeekday = cal.component(.weekday, from: monthStart) - 1
        let daysInMonth  = cal.range(of: .day, in: .month, for: currentMonth)!.count

        var days: [Date?] = Array(repeating: nil, count: firstWeekday)
        for day in 1...daysInMonth {
            if let date = cal.date(byAdding: .day, value: day - 1, to: monthStart) {
                days.append(date)
            }
        }
        while days.count % 7 != 0 { days.append(nil) }
        return days
    }

    func previousMonth() {
        currentMonth = Calendar.current.date(
            byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }

    func nextMonth() {
        currentMonth = Calendar.current.date(
            byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }

    func setMonth(_ index: Int) {
        var comps = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        comps.month = index + 1
        currentMonth = Calendar.current.date(from: comps) ?? currentMonth
    }

    func setYear(_ year: Int) {
        var comps = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        comps.year = year
        currentMonth = Calendar.current.date(from: comps) ?? currentMonth
    }

    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }

    func isSelected(_ date: Date) -> Bool {
        guard let sel = selectedDate else { return false }
        return Calendar.current.isDate(date, inSameDayAs: sel)
    }

    func isOvulation(_ date: Date) -> Bool {
        let day = Calendar.current.component(.day, from: date)
        return (10...13).contains(day)
    }

    func hasMood(for date: Date, moodVM: MoodViewModel) -> Bool {
        moodVM.mood(for: date) != nil
    }
}
