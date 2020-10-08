//
//  TabViewController.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct TabViewController: View {
    @EnvironmentObject var user : User
    @Binding var isLoggedIn : Bool
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem({Image(systemName: "house.fill")})
            FavCafeScreen()
                .tabItem({Image(systemName: "burst.fill")})
            FavRestaurantScreen()
                .tabItem({Image(systemName: "smallcircle.fill.circle.fill")})
            ProfileScreen(isLoggedIn: $isLoggedIn)
                .tabItem({Image(systemName: "person.fill")})
        }.accentColor(.green)
        .environmentObject(user)
    }
}
