//
//  CafeDetailView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 08/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteCafe : View {
    @EnvironmentObject var user : User
    var restaurant : Cafe
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
                    let index : Int = self.user.favoriteCafes.firstIndex { (c) -> Bool in
                        c.name == self.restaurant.name
                    }!
                    self.user.favoriteCafes.remove(at: index)
                    print("isFav = ", self.user.favoriteCafes.count)
                } else {
                    self.user.favoriteCafes.append(self.restaurant)
                    print("is not Fav = ", self.user.favoriteCafes.count)
                }
                self.user.saveDataToFirestore()
                self.isFav.toggle()
        }
    }
}

struct CafeDetailView: View {
    @EnvironmentObject var user : User
    var restaurant : Cafe
    @State var isFav = true
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: restaurant.featured_image)!)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, alignment: .center)
                .overlay(
                    isFav ?
                        FavoriteCafe(restaurant: restaurant, iconName: "heart.fill", isFav: $isFav) : FavoriteCafe(restaurant :restaurant, iconName: "heart", isFav: $isFav)
                    , alignment: .bottomTrailing)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(restaurant.name).font(.title).bold()
                    Spacer()
                    Image(systemName: "star.fill").foregroundColor(.yellow).font(.system(size: 15))
                    Text(restaurant.user_rating.rating_obj.title.text).font(.system(size: 17))
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
        for c in user.favoriteCafes {
            if c.name == restaurant.name {
                isFav = true
                return
            }
        }
        isFav = false
    }
}
