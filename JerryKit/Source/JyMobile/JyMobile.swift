//
//  JyMobile.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import UIKit

public class JyMobile {
    public init(){
    }
    // i8  = 1334
    // i8+ = 2208
    // i11 = 1792
    // i11Pro = 2436
    // i11ProMax = 2688
    // MARK: 檢查是否為iphoneX系列
    public func isiPhoneXFamily() -> Bool {
        let uih = UIScreen.main.nativeBounds.height
        if uih == 1792 || uih == 2436 || uih == 2688 { // iPhoneX系列
            return true
        } else {
            return false
        }
    }
}
