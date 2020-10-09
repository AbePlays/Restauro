//
//  RestaurantListView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 08/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantListView: View {
    var restaurant : Restaurant
    var body: some View {
        HStack(alignment: .top) {
            WebImage(url: URL(string: restaurant.thumb ?? "https://fitmirchi.com/admin/assets/images/image_not_available.png"))
                .resizable()
                .placeholder(Image("placeholder_food"))
                .indicator(.activity)
                .scaledToFit()
                .frame(width: 80, alignment: .center)
                .cornerRadius(10)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(restaurant.name).font(.system(size: 20)).bold()
                Text(restaurant.cuisines).font(.system(size: 15)).foregroundColor(.gray).bold()
                HStack(spacing: 5) {
                    Image(systemName: "star.fill").font(.system(size: 15)).foregroundColor(.yellow)
                    Text("\(restaurant.user_rating.aggregate_rating)").font(.system(size: 15)).foregroundColor(.gray)
                    Text("(\(restaurant.user_rating.votes))").font(.system(size: 15)).foregroundColor(.gray)
                }
            }
            Spacer()
        }.padding(10).background(Color.white).cornerRadius(10).shadow(radius: 3).padding(.horizontal, 15)
    }
}
