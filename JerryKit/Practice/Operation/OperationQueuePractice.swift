//
//  OperationQueuePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class OperationQueuePractice: BasePractice {
    func startTest() {
//        test()
        test2()
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
    
    private func test2() {
        let queue = OperationQueue()

        var flag = false
        let operation1 = BlockOperation {
            // 模拟一个操作是否成功
            flag = true
            print("Operation 1 in \(Thread.current).")
            Thread.sleep(forTimeInterval: 2)
        }

        // 监听 Operation 1 是否完成
        operation1.completionBlock = {
            print("Operation 1 is completed.")
        }

        let operation2 = BlockOperation {
            if flag {
                print("Operation 2 in \(Thread.current).")
            } else {
                print("Something went wrong.")
            }
        }

        operation2.addDependency(operation1)

        // 过两秒之后控制台才会打印 Operation1 完成和 Operation2 的执行信息
        queue.addOperation(operation1)
        queue.addOperation(operation2)
    }
}
