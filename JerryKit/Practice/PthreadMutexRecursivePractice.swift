//
//  PthreadMutexRecursivePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/8/31.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class PthreadMutexRecursivePractice {
    func startTest() {
        test()
    }
}
extension PthreadMutexRecursivePractice {
    private func test() {
        var pMutex = pthread_mutex_t()
        var pMutexAtt = pthread_mutexattr_t()
        pthread_mutexattr_init(&pMutexAtt)
        pthread_mutexattr_settype(&pMutexAtt, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&pMutex, &pMutexAtt)

        func testRecursive1(count: Int) {
            print("T1 count: \(count) Start")
            pthread_mutex_lock(&pMutex)
            print("T1 count: \(count) Enter")
            sleep(1)
            if count < 5 {
                testRecursive1(count: count+1)
            }
            pthread_mutex_unlock(&pMutex)
            print("T1 count: \(count) Leave")
        }
        func testRecursive2(count: Int) {
            print("T2 count: \(count) Start")
            pthread_mutex_lock(&pMutex)
            print("T2 count: \(count) Enter")
            sleep(1)
            if count < 5 {
                testRecursive2(count: count+1)
            }
            pthread_mutex_unlock(&pMutex)
            print("T2 count: \(count) Leave")
        }
        Thread {
            testRecursive1(count: 0)
        }.start()
        Thread {
            testRecursive2(count: 0)
        }.start()
    }
}
