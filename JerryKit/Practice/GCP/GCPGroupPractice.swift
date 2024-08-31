//
//  GCPGroupPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//
class GCPGroupPractice {
    func startTest() {
//        startTest1()
        startTest2()
    }
}
extension GCPGroupPractice {
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
                
        let queue1 = DispatchQueue(label: "GCPGroup1", attributes: .concurrent)
        queue1.async(group: group) {
          for i in 1...3 {
            print("queue1: \(i)")
          }
        }
                
        let queue2 = DispatchQueue(label: "GCPGroup2", attributes: .concurrent)
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
                
        let queue1 = DispatchQueue(label: "GCPGroup1", attributes: .concurrent)
        queue1.async(group: group) {
          for i in 1...3 {
            print("queue1: \(i)")
          }
        }
                
        let queue2 = DispatchQueue(label: "GCPGroup2", attributes: .concurrent)
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
}
