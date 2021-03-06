//
//  CafeScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct CafeScreen: View {
    @EnvironmentObject var user : User
    @State var cafes = [Cafes]()
    @State var loading = true
    var body: some View {
        VStack {
            if loading {
                Text("Loading...").font(.title)
            } else {
                if self.cafes.count == 0 {
                    Text("Sorry, no cafes found :(").font(.title)
                } else {
                    List {
                        ForEach(cafes, id:\.restaurant.id) { c in
                            NavigationLink(destination: CafeDetailView(restaurant: c.restaurant)) {
                                Text("\(c.restaurant.name)")
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: getCafes)
            .navigationBarTitle("Cafes")
    }
    
    func getCafes() {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/search?entity_id=\(self.user.cityId)&entity_type=zone&establishment_type=1") else {
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
                if let decodedResponse = try? JSONDecoder().decode(decodeCafe.self, from: data) {
                    DispatchQueue.main.async {
                        self.cafes = decodedResponse.restaurants
                        self.loading = false
                    }
                    return
                }
            }
        }.resume()
    }
}

struct CafeScreen_Previews: PreviewProvider {
    static var previews: some View {
        CafeScreen()
    }
}
