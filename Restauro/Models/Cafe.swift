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
    var featured_image : String
    var phone_numbers : String
    var cuisines : String
    var user_rating : CafeRating
}

struct CafeLocation : Codable {
    var address : String
}

struct CafeRating : Codable {
    var votes : Int
    var rating_obj : CafeTitle
}

struct CafeTitle : Codable {
    var title : CafeText
}

struct CafeText : Codable {
    var text : String
}
