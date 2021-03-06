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
    // MARK: - 計算2點的距離
    public func calculateTrigonometric(lat1:Double, lng1:Double, lat2:Double, lng2:Double) -> Double {
        let point1 = CLLocation(latitude: lat1, longitude: lng1)
        let point2 = CLLocation(latitude: lat2, longitude: lng2)
        return point1.distance(from: point2)
    }
}
