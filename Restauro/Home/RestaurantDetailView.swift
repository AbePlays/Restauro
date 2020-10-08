//
//  DetailView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRestaurant : View {
    @EnvironmentObject var user : User
    var restaurant : Restaurant
    var iconName : String
    @Binding var isFav : Bool
    var body : some View {
        ZStack {
            Color.white.frame(width: 50, height: 50).cornerRadius(25)
            Image(systemName: iconName)
                .foregroundColor(.red)
                .font(.system(size: 30))
                .padding()
        }.padding(5)
            .onTapGesture {
                if self.isFav {
                    let index : Int = self.user.favoriteRestaurants.firstIndex { r -> Bool in
                        r.name == self.restaurant.name
                    }!
                    self.user.favoriteRestaurants.remove(at: index)
                } else {
                    self.user.favoriteRestaurants.append(self.restaurant)
                }
                self.user.saveDataToFirestore()
                self.isFav.toggle()
        }
    }
}

struct RestaurantDetailView: View {
    @EnvironmentObject var user : User
    var restaurant : Restaurant
    @State var isFav = true
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: restaurant.featured_image)!)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, alignment: .center)
                .overlay(
                    isFav ?
                        FavoriteRestaurant(restaurant: restaurant, iconName: "heart.fill", isFav: $isFav) : FavoriteRestaurant(restaurant: restaurant, iconName: "heart", isFav: $isFav)
                    , alignment: .bottomTrailing)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(restaurant.name).font(.title).bold()
                    Spacer()
                    Image(systemName: "star.fill").foregroundColor(.yellow).font(.system(size: 15))
                    Text(restaurant.user_rating.aggregate_rating).font(.system(size: 17))
                    Text("(\(restaurant.user_rating.votes))").font(.system(size: 17)).foregroundColor(.gray)
                }
                Text("Address : \(restaurant.location.address)").font(.subheadline).opacity(0.5)
                Text("Timings : \(restaurant.timings)").font(.subheadline).opacity(0.5)
                Text("Phone Number : \(restaurant.phone_numbers)").font(.subheadline).opacity(0.5)
                Text("Cuisines : \(restaurant.cuisines)").font(.subheadline).opacity(0.5)
                
            }.padding()
            
            Spacer()
        }.onAppear(perform: calcFav)
    }
    
    func calcFav() {
        for r in user.favoriteRestaurants {
            if r.name == restaurant.name {
                isFav = true
                return
            }
        }
        isFav = false
    }
}
