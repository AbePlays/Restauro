//
//  ProfileScreen.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileScreen: View {
    @EnvironmentObject var user : User
    @Binding var isLoggedIn : Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                Image("person")
                    .resizable()
                    .clipped()
                    .scaledToFit()
                    .cornerRadius(100)
                    .frame(height: 200)
                    .padding(.vertical, 20)
                
                Text("Hi, \(user.name)").font(.title)
                
                
                NavigationLink(destination : Text("Hi")) {
                    HStack {
                        Text("Change Name")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.black)
                }
                .padding(.vertical, 10)
                NavigationLink(destination : Text("Hi")) {
                    HStack {
                        Text("Change Password")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.black)

                }
                .padding(.vertical, 10)
                NavigationLink(destination : Text("Hi")) {
                    HStack {
                        Text("App Settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.black)

                }
                .padding(.vertical, 10)
                NavigationLink(destination : Text("Hi")) {
                    HStack {
                        Text("Help and Support")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.foregroundColor(.black)

                }
                .padding(.vertical, 10)
                
                ZStack {
                    Color.red.frame(height: 50).cornerRadius(5)
                    Text("Sign out").foregroundColor(.white).bold()
                }.padding(.vertical, 10)
                .onTapGesture(perform: handleSignout)
                
            }
            .padding(.horizontal, 15)
            .navigationBarTitle("Profile")
        }
    }
    
    func handleSignout() {
        print("Inside Signout Handler")
        do {
            try Auth.auth().signOut()
            self.user.deleteUser()
            self.isLoggedIn = false
        } catch {
            print("Error signing out")
        }
    }
}
