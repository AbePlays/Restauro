//
//  Signin.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI
import Firebase

struct Signup: View {
    @EnvironmentObject var user : User
    @Binding var isLoggedIn : Bool
    @State var name : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var confirmPassword : String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Create Your Account").font(.largeTitle).bold().padding(.bottom, 10)
                HStack {
                    Text("Sign up and get started").font(.subheadline).fontWeight(.light)
                    Spacer()
                }
                Image("signup").resizable().scaledToFit()
                    .padding(.vertical, 50)
                TextField("Name", text: $name)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 10)
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 10)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 10)
                SecureField("Confirm Password", text: $confirmPassword)
                    .autocapitalization(.none)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 10)
                ZStack {
                    Color.green.frame(height: 50).cornerRadius(5)
                    Text("Sign up").foregroundColor(.white)
                }
                .onTapGesture(perform: signupHandler)
                .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    Text("Already have an account?")
                    Button(action : {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Log in").foregroundColor(.green)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func signupHandler() {
        print("Inside Signup Handler")
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("\(error?.localizedDescription ?? "Problem while signing up")")
            } else {
                if let res = result {
                    Firestore.firestore().collection("users").document(res.user.uid).setData([
                        "name" : self.name,
                        "email" : self.email,
                        "favoriteCafes" : [],
                        "favoriteRestaurants" : []
                    ])
                    self.user.uid = res.user.uid
                    self.user.loadDataFromFirebase()
                }
                self.isLoggedIn = true
            }
        }
    }
}
