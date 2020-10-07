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
        }.frame(width: 150, height: 180)
            .padding(.horizontal, 40)
            .padding(.vertical, 40)
            .border(Color.black, width: 2)
    }
}

struct PlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCard(place: "Cafe", iconName: "cafe")
    }
}
