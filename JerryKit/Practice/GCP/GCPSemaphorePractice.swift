//
//  GCPSemaphorePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class GCPSemaphorePractice {
    func startTest() {
        test1()
    }
}
extension GCPSemaphorePractice {
//    test start
//    test wait
//    等3秒
//    process start
//    process end
//    test end
    private func test1() {
        semaphoreTest()
    }
    private func semaphoreTest() {
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
}
