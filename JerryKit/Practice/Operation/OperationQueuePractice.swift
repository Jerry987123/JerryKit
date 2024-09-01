//
//  OperationQueuePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class OperationQueuePractice: BasePractice {
    func startTest() {
        test()
    }
}
extension OperationQueuePractice {
    private func test() {
        let printerQueue = OperationQueue()
        printerQueue.maxConcurrentOperationCount = 2
        printerQueue.addOperation { print("1"); sleep(2) }
        printerQueue.addOperation { print("2"); sleep(2) }
        printerQueue.addOperation { print("3"); sleep(2) }
        printerQueue.addOperation { print("4"); sleep(2) }
        printerQueue.addOperation { print("5"); sleep(2) }
        printerQueue.addOperation { print("6"); sleep(2) }
            
        //阻塞在这里
        printerQueue.waitUntilAllOperationsAreFinished()
    }
}
