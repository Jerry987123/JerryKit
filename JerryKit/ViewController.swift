//
//  ViewController.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var basePractice: BasePractice?
    var combinePractice: CombinePractice?

    override func viewDidLoad() {
        super.viewDidLoad()
        // btn test
//        addBtn()
        // GCD test
//        GCDPractice().startTest()
//        GCDGroupPractice().startTest()
//        GCDWorkItemPractice().startTest()
//        GCDSemaphorePractice().startTest()
//        basePractice = GCDBarrierPractice()
        // Operation
//        BlockOperationPracrtice().startTest()
//        basePractice = CustomOperationPractice()
//        basePractice = OperationQueuePractice()
        // Lock
//        OSUnfairLockPractice().startTest()
//        PthreadMutexRecursivePractice().startTest()
//        pthreadMutexConditionPractice().startTest()
//        NSLockPractice().startTest()
//        NSLockConditionPractice().startTest()
//        NSLockConditionLockPractice().startTest()
//        basePractice = ActorPractice()
//        basePractice = ActorPractice2()
        basePractice = ActorPractice3()
//        basePractice = SendablePractice()
        // Combine
        combinePractice = CombinePractice()
        basePractice = combinePractice
        
        basePractice?.startTest()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let data = Item(title: "我是一隻魚")
        NotificationCenter.default.post(name: .dataLoaded, object: data)
        print(combinePractice?.titleLabel.text ?? "123")
    }
}
// private
extension ViewController {
    private func addBtn(){
        let btn = UIButton()
        btn.addTarget(self, action: #selector(tap), for: .touchUpInside)
        btn.backgroundColor = .yellow
        btn.setTitle("show web", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    @objc private func tap(){
        JyInternet().showWeb("https://www.google.com")
    }
}

