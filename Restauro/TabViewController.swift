//
//  TabViewController.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct TabViewController: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem({Image(systemName: "house.fill")})
            CafeScreen()
                .tabItem({Image(systemName: "burst.fill")})
            RestaurantScreen()
                .tabItem({Image(systemName: "smallcircle.fill.circle.fill")})
            ProfileScreen()
                .tabItem({Image(systemName: "person.fill")})
        }.accentColor(.green)
    }
}

struct TabViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}