//
//  Signin.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import Firebase

struct Signin: View {
    @EnvironmentObject var user : User
    @Binding var isLoggedIn : Bool
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Welcome Back,").font(.largeTitle).bold().padding(.bottom, 10)
                    HStack {
                        Text("Sign in to continue").font(.subheadline).fontWeight(.light)
                        Spacer()
                    }
                    Image("login").resizable().scaledToFit()
                        .padding(.vertical, 50)
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.bottom, 10)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.bottom, 10)
                    ZStack {
                        Color.green.frame(height: 50).cornerRadius(5)
                        Text("Log in").foregroundColor(.white)
                    }
                    .onTapGesture(perform: loginHandler)
                    .padding(.bottom, 10)
                    HStack {
                        Spacer()
                        Text("Don't have an account?")
                        NavigationLink(destination : Signup(isLoggedIn: $isLoggedIn).environmentObject(user)) {
                            Text("Sign up").foregroundColor(.green)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(20)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func loginHandler() {
        print("Inside Login Handler")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("\(error?.localizedDescription ?? "Problem with signing in")")
            } else {
                self.isLoggedIn = true
            }
        }
    }
}
