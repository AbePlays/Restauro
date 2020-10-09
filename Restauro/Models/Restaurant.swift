//
//  Restaurant.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation

struct decodeRestaurant : Codable {
    var restaurants : [Restaurants]
}

struct Restaurants : Codable {
    var restaurant : Restaurant
}

struct Restaurant : Codable, Identifiable {
    var id : Int
    var name : String
    var location : Location
    var timings : String
    var featured_image : String?
    var thumb : String?
    var phone_numbers : String
    var cuisines : String
    var user_rating : RestaurantRating
}

struct Location : Codable {
    var address : String
}

struct RestaurantRating : Codable {
    var aggregate_rating : String
    var votes : Int
}
