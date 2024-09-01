//
//  ActorPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class ActorPractice: BasePractice {
    func startTest() {
//        test1()
        test2()
        test3()
    }
}

extension ActorPractice {
    private func test1() {
        let store = BalanceStoreActor(accountName: "Tom")
        let accountName = store.accountName
        print(accountName)
        Task {
            await print(store.balance)
            await store.increment(100)
            await print(store.balance)
        }
    }
    // 會有data race
    private func test2() {
        let store = BalanceStore(accountName: "Tom")
        for _ in 0...1000 {
            let when = DispatchTime.now() + .milliseconds(100)
            DispatchQueue.global().asyncAfter(deadline: when) {
                store.increment(100)
            }
        }
        for _ in 0...1000 {
            let when = DispatchTime.now() + .milliseconds(100)
            DispatchQueue.global().asyncAfter(deadline: when) {
                store.increment(-100)
            }
        }
        let when = DispatchTime.now() + .seconds(5)
        DispatchQueue.global().asyncAfter(deadline: when) {
            print("test2 Final balance: \(store.balance)")
        }
    }
    // 用actor修正data race
    private func test3() {
        let store = BalanceStoreActor(accountName: "Tom")
        for _ in 0...1000 {
            let when = DispatchTime.now() + .milliseconds(100)
            DispatchQueue.global().asyncAfter(deadline: when) {
                Task {
                    await store.increment(100)
                }
            }
        }
        for _ in 0...1000 {
            let when = DispatchTime.now() + .milliseconds(100)
            DispatchQueue.global().asyncAfter(deadline: when) {
                Task {
                    await store.increment(-100)
                }
            }
        }
        let when = DispatchTime.now() + .seconds(5)
        DispatchQueue.global().asyncAfter(deadline: when) {
            Task {
                await print("test3 Final balance: \(store.balance)")
            }
        }
    }
}
class BalanceStore {
    let accountName: String // non-isolated
    var balance = 0 // isolated
            
    init(accountName: String) {
        self.accountName = accountName
    }
    
    func increment(_ amount: Int) {
        balance += amount
        print("Balance: \(balance)")
    }
}

actor BalanceStoreActor {
    let accountName: String // non-isolated
    var balance = 0 // isolated
            
    init(accountName: String) {
        self.accountName = accountName
    }
    
    func increment(_ amount: Int) {
        balance += amount
        print("Balance: \(balance)")
    }
}
