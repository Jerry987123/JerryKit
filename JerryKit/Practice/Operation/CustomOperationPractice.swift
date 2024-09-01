//
//  CustomOperationPractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class CustomOperationPractice: BasePractice {
    func startTest() {
        test()
    }
}
extension CustomOperationPractice {
    private func test() {
        let operation = CustomOperationPractice2()
        operation.start()
    }
}

class CustomOperationPractice2: Operation, @unchecked Sendable {
    override func main() {
        print("start operation")
        sleep(3)
        print("end operation")
    }
}
