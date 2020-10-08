//
//  CafeScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct FavCafeScreen: View {
    @EnvironmentObject var user : User
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if user.favoriteCafes.count == 0 {
                        Text("No favorites selected").font(.title)
                    } else {
                        ForEach(user.favoriteCafes, id: \.id) { c in
                            NavigationLink(destination: CafeDetailView(restaurant: c)) {
                                CafeListView(cafe: c)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }.padding(.top, 20)
            }.navigationBarTitle("Favorite Cafes")
        }
    }
}

struct FavCafeScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavCafeScreen()
    }
}
