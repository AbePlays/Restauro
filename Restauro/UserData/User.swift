//
//  User.swift
//  Restauro
//
//  Created by Abhishek Rawat on 08/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation

class User : ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var favoriteCafes = [Cafe]()
    @Published var favoriteRestaurants = [Restaurant]()    
}
