//
//  CafeListView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 08/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CafeListView: View {
    var cafe : Cafe
    var body: some View {
        HStack(alignment: .top) {
            WebImage(url: URL(string: cafe.thumb)!)
                .resizable()
                .scaledToFit()
                .frame(width: 80, alignment: .center)
                .cornerRadius(10)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(cafe.name).font(.system(size: 20)).bold()
                Text(cafe.cuisines).font(.system(size: 15)).foregroundColor(.gray).bold()
                HStack(spacing: 5) {
                    Image(systemName: "star.fill").font(.system(size: 15)).foregroundColor(.yellow)
                    Text("\(cafe.user_rating.rating_obj.title.text)").font(.system(size: 15)).foregroundColor(.gray)
                    Text("(\(cafe.user_rating.votes))").font(.system(size: 15)).foregroundColor(.gray)
                }
            }
            Spacer()
        }.padding(10).background(Color.white).cornerRadius(10).shadow(radius: 3).padding(.horizontal, 15)
    }
}

struct CafeListView_Previews: PreviewProvider {
    static var previews: some View {
        CafeListView(cafe: Cafe(
            id: "1",
            name: "The Bong Twist",
            location: CafeLocation(address: "Victory Point Tower, Level 3, Ballupur Chowk, Ballupur Flyover, Chakrata Road, Ballupur, Dehradun"),
            timings: "9am – 10:30pm (Mon-Sun)",
            featured_image: "https://b.zmtcdn.com/data/pictures/6/18415696/3bcf9cbab02fa2f055e5ebb100cd3a9b.jpg",
            thumb: "https://b.zmtcdn.com/data/reviews_photos/363/e6e384dfa90292ae343edd1a08239363.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
            phone_numbers: "+91 9899201907",
            cuisines: "Bengali, Seafood",
            user_rating: CafeRating(votes: 69, rating_obj: CafeTitle(title: CafeText(text: "3.9")))))
    }
}
