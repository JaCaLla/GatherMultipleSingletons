//
//  GatherMultipleSingletonsTests.swift
//  GatherMultipleSingletonsTests
//
//  Created by Javier Calatrava on 2/12/24.
//

import Testing
@testable import GatherMultipleSingletons

struct GatherMultipleSingletonsTests {

    @Test @MainActor func example() async throws {
        let longTaskManagerMock = LongTaskManagerMock()
        appSingletons = AppSingletons(longTaskManager: longTaskManagerMock)
        #expect(appSingletons.longTaskManager.isTaskDone == false)
        await appSingletons.longTaskManager.doLongTask()
        #expect(appSingletons.longTaskManager.isTaskDone == true)
    }

}

final class LongTaskManagerMock: LongTaskManager {
    
    override func doLongTask() async {
        await MainActor.run {
            isTaskDone = true
        }
    }
}


