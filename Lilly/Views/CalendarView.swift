//
//  CalendarView.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 18/05/2026.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var moodVM: MoodViewModel
    @StateObject private var calVM = CalendarViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 2) {
                    Text("Calendar")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    Text("Ovulation")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.75, green: 0.90, blue: 0.30))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 60)

                // Week tabs
                HStack(spacing: 0) {
                    ForEach(1...4, id: \.self) { week in
                        Button {
                            calVM.selectedWeek = week
                        } label: {
                            Text("week \(week)")
                                .font(.system(size: 13,
                                              weight: calVM.selectedWeek == week ? .semibold : .regular))
                                .foregroundColor(calVM.selectedWeek == week ? .black : .gray)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 14)
                                .background(
                                    Capsule()
                                        .fill(calVM.selectedWeek == week
                                              ? Color.white
                                              : Color.clear)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(4)
                .background(Capsule().fill(Color.white.opacity(0.55)))
                .padding(.horizontal, 20)
                .padding(.top, 16)

                // Calendar card
                VStack(spacing: 0) {

                    // Month/Year navigation
                    HStack {
                        Button { calVM.previousMonth() } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                                .padding(8)
                        }

                        Spacer()

                        Menu {
                            ForEach(0..<12, id: \.self) { i in
                                Button(Calendar.current.monthSymbols[i]) {
                                    calVM.setMonth(i)
                                }
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text(calVM.currentMonthName)
                                    .font(.system(size: 14, weight: .medium))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 10))
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                        }

                        Menu {
                            ForEach(2020...2035, id: \.self) { year in
                                Button("\(year)") { calVM.setYear(year) }
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text("\(calVM.currentYear)")
                                    .font(.system(size: 14, weight: .medium))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 10))
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                        }

                        Spacer()

                        Button { calVM.nextMonth() } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(8)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 12)

                    // Weekday headers
                    HStack {
                        ForEach(calVM.weekdays, id: \.self) { day in
                            Text(day)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)

                    Divider()
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)

                    // Day grid
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7),
                        spacing: 4
                    ) {
                        ForEach(Array(calVM.daysInGrid.enumerated()), id: \.offset) { _, date in
                            if let date = date {
                                DayCell(
                                    date: date,
                                    isToday: calVM.isToday(date),
                                    isOvulation: calVM.isOvulation(date),
                                    isSelected: calVM.isSelected(date),
                                    savedMood: moodVM.mood(for: date)
                                ) {
                                    calVM.selectedDate = date
                                }
                            } else {
                                Color.clear.frame(height: 44)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 16)
                }
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
                .padding(.horizontal, 16)
                .padding(.top, 14)

                Spacer()
            }
        }
    }
}

// MARK: - Day Cell
struct DayCell: View {
    let date: Date
    let isToday: Bool
    let isOvulation: Bool
    let isSelected: Bool
    let savedMood: String?
    let onTap: () -> Void

    private var dayNumber: Int {
        Calendar.current.component(.day, from: date)
    }

    var body: some View {
        Button(action: onTap) {
            ZStack {
                // If this date has a saved mood, show the head asset
                if let _ = savedMood {
                    Image("head")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                } else {
                    Circle()
                        .fill(circleColor)
                        .frame(width: 36, height: 36)

                    Text("\(dayNumber)")
                        .font(.system(size: 14,
                                      weight: (isToday || isSelected) ? .bold : .regular))
                        .foregroundColor(textColor)
                }
            }
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }

    private var circleColor: Color {
        if isSelected || isToday {
            return Color(red: 0.25, green: 0.40, blue: 0.20)
        }
        if isOvulation {
            return Color(red: 0.88, green: 0.94, blue: 0.80)
        }
        return Color.clear
    }

    private var textColor: Color {
        if isSelected || isToday { return .white }
        if isOvulation { return Color(red: 0.30, green: 0.55, blue: 0.20) }
        return .primary
    }
}
