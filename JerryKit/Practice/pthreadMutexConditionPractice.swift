//
//  pthreadMutexConditionPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class pthreadMutexConditionPractice {
    func startTest() {
        pthreadMutexConditionPractice2().test()
    }
}
class pthreadMutexConditionPractice2 {
    // 設定生產結束的條件
    var count = 0.0
    var swtich = true
    // 商品數量
    var product = 0
    // 條件鎖初始化
    var pMutex = pthread_mutex_t()
    var pMutexAtt = pthread_mutexattr_t()
    var pCondition = pthread_cond_t()
    
    func test() {
        pthread_mutexattr_init(&pMutexAtt)
        pthread_mutexattr_settype(&pMutexAtt, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&pMutex, &pMutexAtt)
        pthread_cond_init(&pCondition, nil)
        
        // 設定 0.5 秒會從工廠生產一個產品
        _ = [Timer .scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [self] (timer) in
            print("timer start")
            count += 0.5
            if count > 10 {
                swtich = false
                timer.invalidate()
            }
            Thread { [self] in
                pthread_mutex_lock(&pMutex)
                product += 1
                print("Produce \(product) items")
                pthread_cond_signal(&pCondition)
                print("Producer unlock")
                pthread_mutex_unlock(&pMutex)
            }.start()
        })]
        
        // 設定消費者每兩秒會收購走當前的所有產品
        Thread { [self] in
            while swtich {
                pthread_mutex_lock(&pMutex)
                if product == 0 {
                    print(">>> Consume wait")
                    pthread_cond_wait(&pCondition, &pMutex)
                } else {
                    print(">>> Consume \(product) items")
                    product = 0
                }
                print(">>> Consume unlock")
                pthread_mutex_unlock(&pMutex)
                sleep(2)
            }
        }.start()
    }
}
