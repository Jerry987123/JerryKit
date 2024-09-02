//
//  CombinePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/2.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

import Combine
import UIKit

class CombinePractice: BasePractice {
    
    let titleLabel = UILabel()
    private var cancel: AnyCancellable?
    
    func startTest() {
//        setup()
        setup2()
    }

}
extension CombinePractice {
    private func setup() {
        let publisher = NotificationCenter.Publisher(center: .default, name: .dataLoaded, object: nil).map { noti -> String? in
            return (noti.object as? Item)?.title
        }
        let subscriber = Subscribers.Assign(object: self.titleLabel, keyPath: \.text)
        publisher.subscribe(subscriber)
    }
    private func setup2() {
        let publisher = NotificationCenter.Publisher(center: .default, name: .dataLoaded, object: nil).map { noti -> String? in
            return (noti.object as? Item)?.title
        }
//        let subscriber = Subscribers.Assign(object: self.titleLabel, keyPath: \.text)
//        publisher.subscribe(subscriber)
        self.cancel = publisher.assign(to: \.text, on: self.titleLabel)
    }
}
extension Notification.Name {
    static let dataLoaded = Notification.Name("data_loaded")
}
struct Item {
    let title: String
}
