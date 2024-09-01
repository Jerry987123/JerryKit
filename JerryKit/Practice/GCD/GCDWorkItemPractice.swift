//
//  GCDWorkItemPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class GCDWorkItemPractice {
    func startTest() {
        test2()
    }
}
extension GCDWorkItemPractice {
//    123456
//    Work item is running.
//    等3秒
//    Work item 2 is running.
    private func test1() {
        let workItem = DispatchWorkItem {
            print("Work item is running.")
            sleep(3)
        }
        let workItem2 = DispatchWorkItem {
            print("Work item 2 is running.")
        }
        DispatchQueue.global().async(execute: workItem)
        print("123456")
        workItem.notify(queue: DispatchQueue.global(), execute: workItem2)
        
    }
//    Work item is running.
//    等3秒
//    123456
//    Work item 2 is running.
    private func test2() {
        let workItem = DispatchWorkItem {
            print("Work item is running.")
            sleep(3)
        }
        let workItem2 = DispatchWorkItem {
            print("Work item 2 is running.")
        }
        DispatchQueue.global().async(execute: workItem)
        workItem.wait()
        print("123456")
        
//        workItem.notify(queue: DispatchQueue.global(), execute: workItem2)
        DispatchQueue.global().async(execute: workItem2)
        
    }
}
