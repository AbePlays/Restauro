//
//  ContentView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var user = User()
    @State var isLoggedIn = false
    var body: some View {
        Group {
            if isLoggedIn {
                TabViewController(isLoggedIn: $isLoggedIn).environmentObject(user)
            } else {
                Signin(isLoggedIn: $isLoggedIn).environmentObject(user)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
