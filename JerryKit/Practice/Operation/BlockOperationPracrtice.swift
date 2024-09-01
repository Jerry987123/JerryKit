//
//  BlockOperationPracrtice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class BlockOperationPracrtice {
    func startTest() {
        test()
    }
}
extension BlockOperationPracrtice {
    private func test() {
//        let blockOperation = BlockOperation()
        let blockOperation = BlockOperation {
            print("blockOperation start: \(Thread.current)")
        }
        for i in 1...10 {
            blockOperation.addExecutionBlock {
                sleep(2)
                print("\(i) in blockOperation: \(Thread.current)")
            }
        }
        blockOperation.completionBlock = {
            print("All block operation task finished: \(Thread.current)")
        }
        blockOperation.start()
    }
}
