//
//  HomeScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName : "mappin.and.ellipse").foregroundColor(.orange).padding(.trailing, 5)
                    Text("Your Address").font(.headline)
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.system(size: 25)).padding(.trailing, 10)
                    Image("person").resizable().scaledToFit().frame(width: 35).cornerRadius(25)
                }
                
                Text("What would you\nlike to visit?").font(.system(size: 25)).bold().padding(.vertical, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        NavigationLink(destination : CafeScreen()) {
                            PlaceCard(place: "Cafe", iconName: "cafe")
                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination : RestaurantScreen()) {
                            PlaceCard(place: "Restaurant", iconName: "restaurant")
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
            }.padding()
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
