//
//  NSLockPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class NSLockPractice {
    func startTest() {
        test()
    }
}
extension NSLockPractice {
    private func test() {
        let lock = NSLock()

        Thread {
            print("T1 Start")
            lock.lock()
            print("T1 Enter")
            sleep(2)
            lock.unlock()
            print("T1 Leave")
        }.start()
        Thread {
            sleep(1)
            print("T2 Start")
            let success = lock.try()
            print("T2 lock: \(success)")
            if success {
                print("T2 Enter")
                lock.unlock()
                print("T2 Leave")
            } else {
                print("T2 ignore")
            }
        }.start()
    }
}
