//
//  HomeScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var user : User
    @State var changeCity = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName : "mappin.and.ellipse").foregroundColor(.orange).padding(.trailing, 5)
                    Text(user.city).font(.headline)
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.system(size: 25)).padding(.trailing, 10).onTapGesture {
                        self.changeCity = true
                    }
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
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $changeCity) {
            VStack {
                Spacer()
                Text("Change City").font(.largeTitle).bold().padding(.bottom, 30)
                TextField("City...", text: self.$user.city)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 20)
                ZStack {
                    Color.green.frame(height: 50).cornerRadius(5)
                    Text("Save").foregroundColor(.white).bold()
                }.onTapGesture {
                    self.changeCity = false
                    self.user.saveDataToFirestore()
                }
                Spacer()
            }.padding(50)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
