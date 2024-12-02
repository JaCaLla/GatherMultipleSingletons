//
//  LongTaskManager.swift
//  LocationSampleApp
//
//  Created by Javier Calatrava on 1/12/24.
//
import Foundation
import SwiftUI

@globalActor
actor GlobalManager {
    static var shared = GlobalManager()
}

protocol LongTaskManagerProtocol {
    @MainActor var isTaskDone: Bool { get }
    func doLongTask() async
}

@GlobalManager
class LongTaskManager: ObservableObject, LongTaskManagerProtocol {

    @MainActor
    static let shared = LongTaskManager()

    @MainActor
    @Published var isTaskDone: Bool = false
    
    private var isTaskDoneInternal: Bool = false {
        didSet {
            Task {
                await MainActor.run { [isTaskDoneInternal] in
                    isTaskDone = isTaskDoneInternal
                }
            }
        }
    }

    #if DEBUG
    @MainActor
    /*private*/ init() {
    }
    #else
    @MainActor
    private init() {
    }
    #endif
    
    // MARK :- LongTaskManagerProtocol
    func doLongTask() async {
        isTaskDoneInternal = false
        print("Function started...")
        // Task.sleep takes nanoseconds, so 10 seconds = 10_000_000_000 nanoseconds
        try? await Task.sleep(nanoseconds: 10_000_000_000)
        print("Function finished!")
        isTaskDoneInternal = true
    }
}
