//
//  UserLocation.swift
//  Restauro
//
//  Created by Abhishek Rawat on 09/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation

struct UserLocation : Codable {
    var location_suggestions : [Entity]
}

struct Entity : Codable {
    var entity_id : Int
}
