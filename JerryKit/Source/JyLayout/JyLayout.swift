//
//  JyLayout.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import UIKit

public class JyLayout {
    public init(){
    }
    // 設定constraint
    public func setConstraint( older:inout NSLayoutConstraint?, newer:NSLayoutConstraint?){
        if let older = older {
            older.isActive = false
        }
        older = newer
        if let older = older {
            older.isActive = true
        }
    }
}
