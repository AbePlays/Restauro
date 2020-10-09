//
//  RestaurantScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct RestaurantScreen: View {
    @EnvironmentObject var user : User
    @State var res = [Restaurants]()
    @State var loading = true
    var body: some View {
        VStack {
            if loading {
                Text("Loading...").font(.title)
            } else {
                List {
                    if self.res.count == 0 {
                        Text("Sorry, no restaurants found :(").font(.title)
                    } else {
                        ForEach(res, id:\.restaurant.id) { r in
                            NavigationLink(destination: RestaurantDetailView(restaurant: r.restaurant)) {
                                Text(r.restaurant.name)
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: getRestaurants)
            .navigationBarTitle("Restaurants")
    }
    
    func getRestaurants() {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/search?entity_id=\(self.user.cityId)&entity_type=city&collection_id=1") else {
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
                if let decodedResponse = try? JSONDecoder().decode(decodeRestaurant.self, from: data) {
                    DispatchQueue.main.async {
                        self.res = decodedResponse.restaurants
                        self.loading = false
                    }
                    return
                }
            }
        }.resume()
    }
}

struct RestaurantScreen_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantScreen()
    }
}
