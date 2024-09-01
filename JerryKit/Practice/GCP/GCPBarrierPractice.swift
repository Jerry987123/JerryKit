//
//  GCPBarrierPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class GCPBarrierPractice: BasePractice {
    func startTest() {
        test()
    }
}
extension GCPBarrierPractice {
    private func test() {
        let label = "GCPBarrier"
        let queue = DispatchQueue(label: label, attributes: .concurrent)

        queue.async {
            for i in 0 ..< 2 {
                print("First i: \(i)")
            }
        }
        queue.async {
            for i in 0 ..< 2 {
                print("Second i: \(i)")
            }
        }

        queue.async(flags: .barrier) {
            print("This is a barrier.")
        }

        queue.async {
            for i in 0 ..< 2 {
                print("Third i: \(i)")
            }
        }
        queue.async {
            for i in 0 ..< 2 {
                print("Fourth i: \(i)")
            }
        }
    }
}
