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
            Text("Hello")
            Text("\(res.count)")
        }.onAppear(perform: getRestaurants)
    }
    
    func getRestaurants() {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/search?entity_id=35&entity_type=city&collection_id=1") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("", forHTTPHeaderField: "user-key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("\(error!.localizedDescription)")
                return
            }
            
            if let data = data {
                print("Data", data)
                if let decodedResponse = try? JSONDecoder().decode(Restaurants.self, from: data) {
                    print("Decoded Response : ", decodedResponse)
                    DispatchQueue.main.async {
                        self.res.append(decodedResponse)
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
