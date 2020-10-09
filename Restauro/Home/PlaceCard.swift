//
//  PlaceCard.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct PlaceCard: View {
    var place : String
    var iconName : String
    var body: some View {
        VStack(spacing: 20) {
            Image(iconName).resizable().scaledToFit()
            Text(place).font(.headline).bold()
        }
        .frame(width: 150, height: 180)
        .padding(30)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .padding(10)
    }
}

struct PlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCard(place: "Cafe", iconName: "cafe")
    }
}
