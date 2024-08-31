//
//  GCPPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class GCPPractice {
    func task1() {
        print("Task 1 started")
        // make task1 take longer than task2
        sleep(3)
        print("Task 1 finished")
    }

    func task2() {
        print("Task 2 started")
        print("Task 2 finished")
    }
}
extension GCPPractice {
    func startTest() {
        let serialQueue = DispatchQueue(label: "com.ccy.testGCD")
        serialQueue.sync {
            task1()
         }
        serialQueue.sync {
            task2()
        }
    }
}
