//
//  LillyApp.swift
//  Lilly
//
//  Created by Yasmin Alhabib on 03/05/2026.
//
import SwiftUI

@main
struct LillyApp: App {
    
    @State private var showMainPage = false
    @State private var healthManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            if showMainPage {
                MainPageView()
            } else {
                HealthSetupView(
                    onSyncHealth: {
                        healthManager.requestAuthorization()
                        showMainPage = true
                    },
                    onEnterManually: {
                        print("Enter manually tapped")
                    },
                    onSkip: {
                        showMainPage = true
                    }
                )
            }
        }
    }
}
