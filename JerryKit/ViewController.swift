//
//  ViewController.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // btn test
//        addBtn()
        // GCP test
//        GCPPractice().startTest()
//        GCPGroupPractice().startTest()
//        GCPWorkItemPractice().startTest()
//        GCPSemaphorePractice().startTest()
        // Lock
//        OSUnfairLockPractice().startTest()
//        PthreadMutexRecursivePractice().startTest()
//        pthreadMutexConditionPractice().startTest()
//        NSLockPractice().startTest()
        NSLockConditionPractice().startTest()
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

