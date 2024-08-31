//
//  GCPSemaphorePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class GCPSemaphorePractice {
    func startTest() {
//        test1()
        test2()
    }
}
extension GCPSemaphorePractice {
//    test start
//    test wait
//    process start
//    等3秒
//    process end
//    test end
    private func test1() {
        print("test start")
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            print("process start")
            sleep(3)
            print("process end")
            semaphore.signal() // 任務完成
        }
        print("test wait")
        semaphore.wait() // 等待任務完成後，更新UI
        print("test end")
    }
    private func test2() {
        GCPSemaphorePractice2().startCount()
    }
}
class GCPSemaphorePractice2 {
    let semaphore = DispatchSemaphore(value: 1)
    
    // Shared resource
    var resourceCounter = 0
    
    func startCount() {
        
        // Create a concurrent queue
        let concurrentQueue = DispatchQueue(label: "Queue", attributes: .concurrent)
        
        // Run the tasks concurrently
        concurrentQueue.async { [self] in
            taskOne(semaphore: semaphore)
        }
        
        concurrentQueue.async { [self] in
            taskTwo(semaphore: semaphore)
        }
    }
    
    // Concurrent tasks
    private func taskOne(semaphore: DispatchSemaphore) {
        semaphore.wait() // Acquire the semaphore permit
        for _ in 1...5 {
            print(Thread.current)
            resourceCounter += 1
            print("Task One: \(resourceCounter)")
        }
        semaphore.signal() // Release the semaphore permit
    }
    
    private func taskTwo(semaphore: DispatchSemaphore) {
        semaphore.wait() // Acquire the semaphore permit
        for _ in 1...5 {
            print(Thread.current)
            resourceCounter -= 1
            print("Task Two: \(resourceCounter)")
        }
        semaphore.signal() // Release the semaphore permit
    }
   
}
