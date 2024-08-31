//
//  NSLockConditionPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class NSLockConditionPractice {
    func startTest() {
        NSLockConditionPractice2().test()
    }
}
class NSLockConditionPractice2 {
    // 設定生產結束的條件
    var count = 0.0
    var swtich = true

    // 商品數量
    var product = 0

    // 條件鎖初始化
    var condition = NSCondition()

    func test() {
        // 設定 0.5 秒會從工廠生產一個產品
        _ = [Timer .scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [self] (timer) in
            count += 0.5
            if count > 10 {
                swtich = false
                timer.invalidate()
            }
            Thread { [self] in
                condition.lock()
                product += 1
                print("Produce \(product) items")
                condition.signal()
                condition.unlock()
            }.start()
        })]
        
        // 設定消費者每兩秒會收購走當前的所有產品
        Thread { [self] in
            while swtich {
                condition.lock()
                if product == 0 {
                    condition.wait()
                } else {
                    print(">>> Consume \(product) items")
                    product = 0
                }
                condition.unlock()
                sleep(2)
            }
        }.start()
    }
}
