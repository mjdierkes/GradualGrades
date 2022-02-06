//
//  BackgroundManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/6/22.
//

import Foundation
import UIKit

class BackgroundManager: ObservableObject {
    
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
            selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
        registerBackgroundTask()
    }
    
    func end() {
        updateTimer?.invalidate()
        updateTimer = nil
        // end background task
        if backgroundTask != .invalid {
            endBackgroundTask()
        }
        resetCalculation()
    }
    
   
    
    func resetCalculation() {
        previous = .one
        current = .one
        position = 1
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
        updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                           selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    @objc func reinstateBackgroundTask() {
        if updateTimer != nil && backgroundTask == .invalid {
            registerBackgroundTask()
        }
    }
    
    @objc func calculateNextNumber() {
        let result = current.adding(previous)
        
        let bigNumber = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)
        if result.compare(bigNumber) == .orderedAscending {
            previous = current
            current = result
            position += 1
        } else {
            // This is just too much.... Start over.
            resetCalculation()
        }
        
        let resultsMessage = "Position \(position) = \(current)"
        switch UIApplication.shared.applicationState {
        case .active:
            print("Results Message:", resultsMessage)
        case .background:
            print("App is backgrounded. Next number = \(resultsMessage)")
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            break
        }
        
    }

}
