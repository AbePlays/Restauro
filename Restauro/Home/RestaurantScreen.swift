//
//  RestaurantScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct RestaurantScreen: View {
    @State var res = [Restaurants]()
    var body: some View {
        VStack {
            List {
                ForEach(res, id:\.restaurant.id) { r in
                    Text(r.restaurant.name)
                }
            }
            
        }.onAppear(perform: getRestaurants)
        .navigationBarTitle("Restaurants")
    }
    
    func getRestaurants() {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/search?entity_id=35&entity_type=city&collection_id=1") else {
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
