//
//  NSLockConditionLockPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class NSLockConditionLockPractice {
    func startTest() {
        NSLockConditionLockPractice2().test()
    }
}
class NSLockConditionLockPractice2 {
    // 設定生產結束的條件
    var count = 0.0
    var swtich = true

    // 商品數量
    var product = 0

    // 條件鎖初始化
    var conditionLock = NSConditionLock(condition: 0)

    func test() {
        // 設定 0.5 秒會從工廠生產一個產品
        let _ = [Timer .scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [self] (timer) in
            count += 0.5
            if count > 10 {
                swtich = false
                timer.invalidate()
            }
            Thread { [self] in
                conditionLock.lock()
                product += 1
                print("Produce \(product) items")
                conditionLock.unlock(withCondition: 1)
            }.start()
        })]
        
        // 設定消費者每兩秒會收購走當前的所有產品
        Thread { [self] in
            while swtich {
                conditionLock.lock(whenCondition: 1)
                print(">>> Consume \(product) items")
                product = 0
                conditionLock.unlock(withCondition: 0)
                sleep(2)
            }
        }.start()
    }
}
