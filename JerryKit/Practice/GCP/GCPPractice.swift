//
//  GCPPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class GCPPractice {
    func startTest() {
//        startTest1()
//        startTest2()
//        startTest3()
//        startTest4()
        startTest5()
    }

}
// private
extension GCPPractice {
    //        Task 1 started
    //        等3秒
    //        Task 1 finished
    //        Task 2 started
    //        Task 2 finished
    private func startTest1() {
        let serialQueue = DispatchQueue(label: "GCPPractice")
        serialQueue.sync {
            task1()
         }
        serialQueue.sync {
            task2()
        }
    }
    //        Task 1 started
    //        等3秒
    //        Task 1 finished
    //        Task 2 started
    //        Task 2 finished
    private func startTest2() {
        let serialQueue = DispatchQueue(label: "GCPPractice")
        serialQueue.async {
            self.task1()
         }
        serialQueue.async {
            self.task2()
        }
    }
    //        Task 1 started
    //        等3秒
    //        Task 1 finished
    //        Task 2 started
    //        Task 2 finished
    private func startTest3() {
        let serialQueue = DispatchQueue(label: "GCPPractice", attributes: .concurrent)
        serialQueue.sync {
            task1()
         }
        serialQueue.sync {
            task2()
        }
    }
    //        Task 1 started
    //        Task 2 started
    //        Task 2 finished
    //        等3秒
    //        Task 1 finished
    private func startTest4() {
        let serialQueue = DispatchQueue(label: "GCPPractice", attributes: .concurrent)
        serialQueue.async {
            self.task1()
         }
        serialQueue.async {
            self.task2()
        }
    }
    
    private func startTest5() {
        print("Task started")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          print("task finished")
        }
    }
    
    private func task1() {
        print("Task 1 started")
        // make task1 take longer than task2
        sleep(3)
        print("Task 1 finished")
    }

    private func task2() {
        print("Task 2 started")
        print("Task 2 finished")
    }
}
