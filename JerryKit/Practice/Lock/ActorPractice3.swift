//
//  ActorPractice3.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class ActorPractice3: BasePractice {
    func startTest() {
        test1()
    }
}
extension ActorPractice3 {
    func test1() {
        Task {
            await AccountManager().withdraw()
        }
    }
}
actor BankAccount {
  let accountNumber: Int
  var balance: Double

  enum BankAccountError: Error {
    case insufficientBalance(Double)
    case authorizeFailed
  }

  init(accountNumber: Int, initialDeposit: Double) {
    self.accountNumber = accountNumber
    self.balance = initialDeposit
  }

  func deposit(amount: Double) {
    assert(amount >= 0)
    balance = balance + amount
  }
}
extension BankAccount {
  // 在该方法内部只引用了 let accountNumber，故不存在 Data races
  // 也就可以用 nonisolated 修饰
  nonisolated func safeAccountNumberDisplayString() -> String {
    let digits = String(accountNumber)
    return String(repeating: "X", count: digits.count - 4) + String(digits.suffix(4))
  }
}
extension BankAccount {
  func transfer(amount: Double, to other: BankAccount) throws {
    if amount > balance {
      throw BankAccountError.insufficientBalance(balance)
    }

    print("Transferring \(amount) from \(accountNumber) to \(other.accountNumber)")

    balance = balance - amount
    // Actor-isolated property 'balance' can not be mutated on a non-isolated actor instance
    // Actor-isolated property 'balance' can not be referenced on a non-isolated actor instance
//    other.balance = other.balance + amount  // error: actor-isolated property 'balance' can only be referenced on 'self'
  }
}
extension BankAccount {
  private func authorize() async -> Bool {
    // Simulate the authentication process
    //
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return true
  }

  func withdraw(amount: Double) async throws -> Double {
    guard balance >= amount else {
      throw BankAccountError.insufficientBalance(balance)
    }

    // suspension point
    //
    guard await authorize() else {
      throw BankAccountError.authorizeFailed
    }

    // re-check
    guard balance >= amount else {
        throw BankAccountError.insufficientBalance(balance)
    }
      
    balance -= amount
    return balance
  }
}
class AccountManager {
  let bankAccount = BankAccount.init(
    accountNumber: 123456789,
    initialDeposit: 1000
  )

  func withdraw() async {
    for _ in 0..<2 {
      Task {
        let amount = 600.0
        do {
          let balance = try await bankAccount.withdraw(amount: amount)
          print("Withdrawal succeeded, balance = \(balance)")
        } catch let error as BankAccount.BankAccountError {
          switch error {
          case .insufficientBalance(let balance):
            print("Insufficient balance, balance = \(balance), withdrawal amount = \(amount)!")
          case .authorizeFailed:
            print("Authorize failed!")
          }
        }
      }
    }
  }
}

//
//作者：峰之巅
//链接：https://juejin.cn/post/7076738494869012494
//来源：稀土掘金
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
