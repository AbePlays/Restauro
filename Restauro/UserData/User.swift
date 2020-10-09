//
//  User.swift
//  Restauro
//
//  Created by Abhishek Rawat on 08/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import Foundation
import Firebase

class User : ObservableObject {
    @Published var uid = ""
    @Published var name = ""
    @Published var email = ""
    @Published var city = ""
    @Published var cityId = 0
    @Published var favoriteCafes = [Cafe]()
    @Published var favoriteRestaurants = [Restaurant]()
    
    func loadDataFromFirebase() {
        Firestore.firestore().collection("users").document(uid).getDocument { (docSnapshot, error) in
            if error != nil {
                print("\(error?.localizedDescription ?? "Couldn't fetch data from Firebase")")
            } else {
                if let docs = docSnapshot {
                    let data = docs.data()!
                    self.name = data["name"] as! String
                    self.email = data["email"] as! String
                    self.city = data["city"] as! String
                    self.cityId = data["cityId"] as! Int
                    let firebaseFavCafe = data["favoriteCafes"] as! [Any]
                    let firebaseFavRestaurant = data["favoriteRestaurants"] as! [Any]
                    for cafe in firebaseFavCafe {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: cafe, options: [])
                            let c = try JSONDecoder().decode(Cafe.self, from: jsonData)
                            self.favoriteCafes.append(c)
                        } catch {
                            print("Error decoding data")
                        }
                    }
                    
                    for restaurant in firebaseFavRestaurant {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: restaurant, options: [])
                            let r = try JSONDecoder().decode(Restaurant.self, from: jsonData)
                            self.favoriteRestaurants.append(r)
                        } catch {
                            print("Error decoding data")
                        }
                    }
                }
            }
        }
    }
    
    func saveDataToFirestore() {
        var firebaseFavCafe = [Any]()
        var firebaseFavRestaurant = [Any]()
        
        for item in self.favoriteCafes {
            do {
                let jsonData = try JSONEncoder().encode(item)
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                firebaseFavCafe.append(jsonObject)
            } catch {
                print("Error while encoding data from Firebase")
            }
        }
        
        for item in self.favoriteRestaurants {
            do {
                let jsonData = try JSONEncoder().encode(item)
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                firebaseFavRestaurant.append(jsonObject)
            } catch {
                print("Error while encoding data")
            }
        }
        
        let params: [String: Any] = [
            "favoriteCafes" : firebaseFavCafe,
            "favoriteRestaurants" : firebaseFavRestaurant,
            "city" : self.city,
            "name" : self.name,
            "cityId" : self.cityId
        ]
        
        Firestore.firestore().collection("users").document(uid).updateData(params)
    }
    
    func deleteUser() {
        self.name = ""
        self.email = ""
        self.city = ""
        self.cityId = 0
        self.favoriteCafes = [Cafe]()
        self.favoriteRestaurants = [Restaurant]()
    }
}
