//
//  DetailView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct Favorite : View {
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
                self.isFav.toggle()
        }
    }
}

struct DetailView: View {
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
                        Favorite(iconName: "heart.fill", isFav: $isFav) : Favorite(iconName: "heart", isFav: $isFav)
                    , alignment: .bottomTrailing)
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(restaurant.name).font(.title).bold()
                    Spacer()
                    Image(systemName: "star.fill").foregroundColor(.yellow).font(.system(size: 15))
                    Text(restaurant.user_rating.aggregate_rating).font(.system(size: 17))
                }
                Text("Address : \(restaurant.location.address)").font(.subheadline).opacity(0.5)
                Text("Timings : \(restaurant.timings)").font(.subheadline).opacity(0.5)
                Text("Phone Number : \(restaurant.phone_numbers)").font(.subheadline).opacity(0.5)
                Text("Cuisines : \(restaurant.cuisines)").font(.subheadline).opacity(0.5)
                
            }.padding()
            
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(restaurant: Restaurant(
            id: 1,
            name: "The Bong Twist",
            location: Location(address: "Victory Point Tower, Level 3, Ballupur Chowk, Ballupur Flyover, Chakrata Road, Ballupur, Dehradun"),
            timings: "9am – 10:30pm (Mon-Sun)",
            featured_image: "https://b.zmtcdn.com/data/pictures/6/18415696/3bcf9cbab02fa2f055e5ebb100cd3a9b.jpg",
            phone_numbers: "+91 9899201907",
            cuisines: "Bengali, Seafood",
            highlights: [
                "Lunch",
                "Cash",
                "Delivery",
                "Credit Card",
                "No Alcohol Available",
                "Dinner",
                "Takeaway Available",
                "Debit Card",
                "Indoor Seating",
                "Table booking recommended",
                "Digital Payments Accepted",
                "Smoking Area"
            ],
            user_rating: RestaurantRating(aggregate_rating: "4.1"))
        )
    }
}
