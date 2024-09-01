//
//  GCDGroupPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//
class GCDGroupPractice {
    func startTest() {
//        startTest1()
//        startTest2()
//        startTest3()
        startTest4()
    }
}
extension GCDGroupPractice {
//    queue1: 1
//    queue1: 2
//    queue1: 3
//    等3秒
//    queue2: 1
//    queue2: 2
//    queue2: 3
//    wait a minute
//    tasks finished
    private func startTest1() {
        let group = DispatchGroup()
                
        let queue1 = DispatchQueue(label: "GCDGroup1", attributes: .concurrent)
        queue1.async(group: group) {
          for i in 1...3 {
            print("queue1: \(i)")
          }
        }
                
        let queue2 = DispatchQueue(label: "GCDGroup2", attributes: .concurrent)
        queue2.async(group: group) {
          sleep(3)
          for i in 1...3 {
            print("queue2: \(i)")
          }
        }
          
        group.wait()
        print("wait a minute")
        group.notify(queue: .main) {
          print("tasks finished")
        }
    }
//    wait a minute
//    queue1: 1
//    queue1: 2
//    queue1: 3
//    等3秒
//    queue2: 1
//    queue2: 2
//    queue2: 3
//    tasks finished
    private func startTest2() {
        let group = DispatchGroup()
                
        let queue1 = DispatchQueue(label: "GCDGroup1", attributes: .concurrent)
        queue1.async(group: group) {
          for i in 1...3 {
            print("queue1: \(i)")
          }
        }
                
        let queue2 = DispatchQueue(label: "GCDGroup2", attributes: .concurrent)
        queue2.async(group: group) {
          sleep(3)
          for i in 1...3 {
            print("queue2: \(i)")
          }
        }
          
//        group.wait()
        print("wait a minute")
        group.notify(queue: .main) {
          print("tasks finished")
        }
    }
//    queue1: 1
//    queue1: 2
//    queue1: 3
//    tasks finished
//    等3秒
//    queue2: 1
//    queue2: 2
//    queue2: 3
    private func startTest3() {
        let group = DispatchGroup()
                
        let queue1 = DispatchQueue(label: "GCDGroup1", attributes: .concurrent)
        queue1.async(group: group) {
            DispatchQueue.global().async {
                for i in 1...3 {
                    print("queue1: \(i)")
                }
            }
        }
                
        let queue2 = DispatchQueue(label: "GCDGroup2", attributes: .concurrent)
        queue2.async(group: group) {
            DispatchQueue.global().async {
                sleep(3)
                for i in 1...3 {
                    print("queue2: \(i)")
                }
            }
        }
        group.notify(queue: .main) {
          print("tasks finished")
        }
    }
//    queue1: 1
//    queue1: 2
//    queue1: 3
//    等3秒
//    queue2: 1
//    queue2: 2
//    queue2: 3
//    tasks finished
    private func startTest4() {
        let group = DispatchGroup()
                
        let queue1 = DispatchQueue(label: "GCDGroup1", attributes: .concurrent)
        group.enter()
        queue1.async(group: group) {
            DispatchQueue.global().async {
                for i in 1...3 {
                    print("queue1: \(i)")
                }
                group.leave()
            }
        }
                
        let queue2 = DispatchQueue(label: "GCDGroup2", attributes: .concurrent)
        group.enter()
        queue2.async(group: group) {
            DispatchQueue.global().async {
                sleep(3)
                for i in 1...3 {
                    print("queue2: \(i)")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
          print("tasks finished")
        }
    }
}
