//
//  HealthKitManager.swift
//  Lilly
//
//  Created by maha althwab on 26/11/1447 AH.
//

import Foundation
import HealthKit

@Observable
class HealthKitManager {
    
    private let healthStore = HKHealthStore()
    
    var age: Int?
    var biologicalSex: String = "Not Set"
    var height: Double?
    var weight: Double?
    
    var lastPeriodStartDate: Date?
    var lastPeriodLengthDays: Int?
    var averagePeriodLengthDays: Int?
    
    var isAuthorized = false
    var errorMessage: String?
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            errorMessage = "Health data is not available on this device."
            return
        }
        
        let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!
        let biologicalSexType = HKObjectType.characteristicType(forIdentifier: .biologicalSex)!
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        let menstrualFlowType = HKCategoryType.categoryType(forIdentifier: .menstrualFlow)!
        
        let readTypes: Set<HKObjectType> = [
            dateOfBirth,
            biologicalSexType,
            heightType,
            weightType,
            menstrualFlowType
        ]
        
        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                self.isAuthorized = success
                
                if success {
                    self.readProfileData()
                }
            }
        }
    }
    
    private func readProfileData() {
        readAge()
        readBiologicalSex()
        readHeight()
        readWeight()
        readMenstrualFlowData()
    }
    
    private func readAge() {
        do {
            let birthDate = try healthStore.dateOfBirthComponents()
            
            if let year = birthDate.year {
                let currentYear = Calendar.current.component(.year, from: Date())
                age = currentYear - year
            }
        } catch {
            errorMessage = "Could not read age."
        }
    }
    
    private func readBiologicalSex() {
        do {
            let sex = try healthStore.biologicalSex().biologicalSex
            
            switch sex {
            case .female:
                biologicalSex = "Female"
            case .male:
                biologicalSex = "Male"
            case .other:
                biologicalSex = "Other"
            default:
                biologicalSex = "Not Set"
            }
        } catch {
            errorMessage = "Could not read biological sex."
        }
    }
    
    private func readHeight() {
        guard let heightType = HKQuantityType.quantityType(forIdentifier: .height) else {
            return
        }
        
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )
        
        let query = HKSampleQuery(
            sampleType: heightType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor]
        ) { _, samples, _ in
            
            guard let sample = samples?.first as? HKQuantitySample else {
                return
            }
            
            let heightInCm = sample.quantity.doubleValue(for: .meterUnit(with: .centi))
            
            DispatchQueue.main.async {
                self.height = heightInCm
            }
        }
        
        healthStore.execute(query)
    }
    
    private func readWeight() {
        guard let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            return
        }
        
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )
        
        let query = HKSampleQuery(
            sampleType: weightType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor]
        ) { _, samples, _ in
            
            guard let sample = samples?.first as? HKQuantitySample else {
                return
            }
            
            let weightInKg = sample.quantity.doubleValue(for: .gramUnit(with: .kilo))
            
            DispatchQueue.main.async {
                self.weight = weightInKg
            }
        }
        
        healthStore.execute(query)
    }
    
    private func readMenstrualFlowData() {
        guard let menstrualFlowType = HKCategoryType.categoryType(forIdentifier: .menstrualFlow) else {
            return
        }
        
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .month, value: -12, to: Date())
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: Date(),
            options: .strictStartDate
        )
        
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
            ascending: false
        )
        
        let query = HKSampleQuery(
            sampleType: menstrualFlowType,
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [sortDescriptor]
        ) { _, samples, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let samples = samples as? [HKCategorySample] else {
                return
            }
            
            let flowSamples = samples.filter { sample in
                sample.value == HKCategoryValueSeverity.unspecified.rawValue ||
                sample.value == HKCategoryValueSeverity.mild.rawValue ||
                sample.value == HKCategoryValueSeverity.moderate.rawValue ||
                sample.value == HKCategoryValueSeverity.severe.rawValue
            }
            
            let days = Set(flowSamples.map {
                calendar.startOfDay(for: $0.startDate)
            }).sorted(by: >)
            
            let periods = self.groupConsecutivePeriodDays(days)
            
            DispatchQueue.main.async {
                self.lastPeriodStartDate = periods.first?.last
                self.lastPeriodLengthDays = periods.first?.count
                
                if !periods.isEmpty {
                    let totalDays = periods.map { $0.count }.reduce(0, +)
                    self.averagePeriodLengthDays = totalDays / periods.count
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    private func groupConsecutivePeriodDays(_ days: [Date]) -> [[Date]] {
        let calendar = Calendar.current
        var periods: [[Date]] = []
        var currentPeriod: [Date] = []
        
        for day in days {
            if currentPeriod.isEmpty {
                currentPeriod.append(day)
            } else if let lastDay = currentPeriod.last,
                      let difference = calendar.dateComponents([.day], from: day, to: lastDay).day,
                      difference == 1 {
                currentPeriod.append(day)
            } else {
                periods.append(currentPeriod)
                currentPeriod = [day]
            }
        }
        
        if !currentPeriod.isEmpty {
            periods.append(currentPeriod)
        }
        
        return periods
    }
}
