//
//  ActorPractice2.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class ActorPractice2: BasePractice {
    func startTest() {
        test1()
    }
}

extension ActorPractice2 {
    // TODO: 整理中
    private func test1() {
        let store = BalanceStoreActor2(accountName: "Tom")
        let store2 = BalanceStoreActor2(accountName: "John")
        let creditCard = CreditCard() // concurrency domain 1
        
        let blockOperation = BlockOperation {
            print("blockOperation start: \(Thread.current)")
        }
        for i in 1...10 {
            blockOperation.addExecutionBlock {
                sleep(1)
                print("\(i) in blockOperation: \(Thread.current)")
                Task {
                    await store.deposit(100, creditCard) // concurrency domain 2
                }
            }
        }
        for i in 1...10 {
            blockOperation.addExecutionBlock {
                sleep(1)
                print("\(i) in blockOperation: \(Thread.current)")
                Task {
                    await store2.deposit(200, creditCard) // concurrency domain 2
                }
            }
        }
        blockOperation.completionBlock = {
            print("All block operation task finished: \(Thread.current)")
            Task {
                await print("\(store.accountName) Final balance: \(store.balance)")
                await print("\(store2.accountName) Final balance: \(store2.balance)")
            }
        }
        blockOperation.start()
    }
}
extension BalanceStoreActor2 {
   func deposit(_ amount: Int, _ creditCard: CreditCard) {
        print("d in blockOperation: \(Thread.current)")
        if creditCard.pay(amount) {
            balance += amount
        }
    }
}
class CreditCard {
  var credit: Int = 3000
  func pay(_ amount: Int) -> Bool {
      if amount <= credit {
          credit -= amount
          return true
      }
      return false
   }
}
actor BalanceStoreActor2 {
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

