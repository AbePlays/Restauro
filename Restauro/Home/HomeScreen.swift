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
                if self.user.city.isEmpty {
                    EmptyView()
                } else {
                    HStack {
                        Image(systemName : "mappin.and.ellipse").foregroundColor(.orange).padding(.trailing, 5)
                        Text(user.city).font(.headline)
                        Spacer()
                        Image(systemName: "pencil.tip.crop.circle").font(.system(size: 25)).padding(.trailing, 10).onTapGesture {
                            self.changeCity = true
                        }
                        Image("person").resizable().scaledToFit().frame(width: 35).cornerRadius(25)
                    }.onAppear(perform: setLocation)
                    
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
                    self.setLocation()
                }
                Spacer()
            }.padding(50)
        }
    }
    
    func setLocation() {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/locations?query=\(self.user.city)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("769b6fd0922075ca2e09b01738beee74", forHTTPHeaderField: "user-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("\(error!.localizedDescription)")
                return
            }
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(UserLocation.self, from: data) {
                    DispatchQueue.main.async {
                        self.user.cityId = decodedResponse.location_suggestions[0].entity_id
                        self.user.saveDataToFirestore()
                    }
                    return
                }
            }
        }.resume()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
