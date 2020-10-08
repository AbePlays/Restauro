//
//  FavRestaurantScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct FavRestaurantScreen: View {
    @EnvironmentObject var user : User
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if user.favoriteRestaurants.count == 0 {
                        Text("No favorites selected").font(.title)
                    } else {
                        ForEach(user.favoriteRestaurants, id: \.id) { r in
                            NavigationLink(destination: RestaurantDetailView(restaurant: r)) {
                                RestaurantListView(restaurant: r)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }.padding(.top, 20)
            }.navigationBarTitle("Favorite Restaurants")
        }
    }
}

struct FavRestaurantScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavRestaurantScreen()
    }
}
