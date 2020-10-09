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
    @State var city : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var confirmPassword : String = ""
    @State var showAlert = false
    @State var errorMessage = ""
    
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
                Group {
                    TextField("Name", text: $name)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.bottom, 10)
                    TextField("City", text: $city)
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
                }
                
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Important message"), message: Text(errorMessage), dismissButton: .default(Text("Got it!")))
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func signupHandler() {
        print("Inside Signup Handler")
        if name.count > 0 && city.count > 0 {
            if password == confirmPassword {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error != nil {
                        print("\(error?.localizedDescription ?? "Problem while signing up")")
                        self.errorMessage = error?.localizedDescription ?? "Problem while signing up"
                        self.showAlert = true
                    } else {
                        if let res = result {
                            Firestore.firestore().collection("users").document(res.user.uid).setData([
                                "name" : self.name,
                                "email" : self.email,
                                "city" : self.city,
                                "cityId" : self.user.cityId,
                                "favoriteCafes" : [],
                                "favoriteRestaurants" : []
                            ])
                            self.user.uid = res.user.uid
                            self.user.loadDataFromFirebase()
                            
                        }
                        self.isLoggedIn = true
                    }
                }
            } else {
                self.errorMessage = "Password don't match"
                self.showAlert = true
                return
            }
        } else {
            self.errorMessage = "Some text fields are empty"
            self.showAlert = true
            return
        }
    }
}
