//
//  OSUnfairLockPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class OSUnfairLockPractice {
    func startTest() {
        test()
    }
}
extension OSUnfairLockPractice {
    private func test() {
        OSUnfairLockPractice2().moneyBox()
    }
}
class OSUnfairLockPractice2 {
    var money = 100
    var lock = os_unfair_lock()
    func moneyBox() {
        // 開啟一個線程進行存錢
        let thread1 = Thread { [self] in
            for _ in 0..<5 {
                saveMoney()
            }
        }
        // 開啟一個線程進行取錢
        let thread2 = Thread { [self] in
            for _ in 0..<5 {
                takeOutMoney()
            }
        }
        thread1.start()
        thread2.start()
    }

    private func saveMoney() {
        os_unfair_lock_lock(&lock)
        // 每次存入10元
        let currentMoney = money
        // delay一下為了讓問題容易發生
        usleep(1000)
        money = (currentMoney + 10)
        print(" + Save 10 dollars, there is [\(money)] dollars in money box")
        os_unfair_lock_unlock(&lock)
    }

    private func takeOutMoney() {
        os_unfair_lock_lock(&lock)
        // 每次取出20元
        let currentMoney = money
        // delay一下為了讓問題容易發生
        usleep(1000)
        money = (currentMoney - 20)
        print(" - Take out 20 dollars, there is [\(money)] dollars in money box")
        os_unfair_lock_unlock(&lock)
    }
}
