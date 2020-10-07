//
//  Restaurant.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation

struct Restaurants : Codable {
    var restaurants : [RestaurantObject]
}

struct RestaurantObject : Codable {
    var restaurant : Restaurant
}

struct Restaurant : Codable {
    var name : String
    var location : Location
    var timings : String
    var thumb : String
    var phone_numbers : String
}

struct Location : Codable {
    var address : String
}
