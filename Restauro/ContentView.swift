//
//  ContentView.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var user = User()
    @State var isLoggedIn = false
    @State var checking = true
    var body: some View {
        Group {
            if !checking {
                if isLoggedIn {
                    TabViewController(isLoggedIn: $isLoggedIn).environmentObject(user)
                } else {
                    Signin(isLoggedIn: $isLoggedIn).environmentObject(user)
                }
            } else {
                Text("Restauro").bold().font(.largeTitle)
            }
        }.onAppear(perform: checkUser)
    }
    
    func checkUser() {
        let result = Auth.auth().currentUser
        if result != nil {
            self.user.uid = result!.uid
            self.user.loadDataFromFirebase()
            self.isLoggedIn = true
        }
        self.checking = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
