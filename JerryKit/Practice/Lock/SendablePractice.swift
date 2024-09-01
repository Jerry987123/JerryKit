//
//  SendablePractice.swift
//  JerryKit
//
//  Created by Chieh-Yi Wu on 2024/9/1.
//  Copyright © 2024 Jerry987123. All rights reserved.
//

class SendablePractice: BasePractice {
    func startTest() {
        test()
    }
}
extension SendablePractice {
    private func test() {
        Task {
            await BookHotel().test()
        }
    }
}
class BookHotel {
    let planer = TravelPlaner()
    let hotels: [Hotel] = []
    var numOfAvailableHotels: Int = 0
    func test() async {
        await planer.book(hotels: hotels, checkAvailability: { hotel in
           let isHotelAvailable = await checkAvailability(of: hotel)
            if isHotelAvailable {
                 numOfAvailableHotels += 1
            }
           return isHotelAvailable
        })
    }
    private func checkAvailability(of hotel: Hotel) async -> Bool {
        return true
    }
}
actor TravelPlaner {
    // 已經訂好的飯店
    var myHotels: [Hotel] = [Hotel(name: "Hotel A"), Hotel(name: "Hotel B"), Hotel(name: "Hotel C")]
    func book(hotels: [Hotel], checkAvailability: @Sendable (Hotel) async -> Bool) async {
        // 針對傳入的飯店一個一個檢查
       for hotel in hotels {
            // 連到外部服務去檢查有沒有空房
           if await checkAvailability(hotel) {
                myHotels.append(hotel)
           }
       }
        print(myHotels)
    }
}
class Hotel: NSObject {
    let name: String
    init(name: String) {
        self.name = name
    }
    override var description: String {
        return name
    }
}
