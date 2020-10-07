//
//  Cafe.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation

struct decodeCafe : Codable {
    var restaurants : [Cafes]
}

struct Cafes : Codable {
    var restaurant : Cafe
}

struct Cafe : Codable, Identifiable {
    var id : String
    var name : String
    var location : CafeLocation
    var timings : String
    var thumb : String
    var phone_numbers : String
}

struct CafeLocation : Codable {
    var address : String
}
