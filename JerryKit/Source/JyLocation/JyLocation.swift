//
//  JyLocation.swift
//  JerryKit
//
//  Created by Jayyi on 2020/10/3.
//  Copyright © 2020 Jerry987123. All rights reserved.
//

import CoreLocation

public class JyLocation {
    public init(){
    }
    // MARK: 是否有開啟定位功能
    public func isGPSOn() -> Bool {
        // 0為未決定;2為deny;3為always;4為wheninuse
        let status = CLLocationManager.authorizationStatus().rawValue
        if status == 3 || status == 4 {
            return true
        } else {
            return false
        }
    }
}
