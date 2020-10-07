//
//  Signin.swift
//  Restauro
//
//  Created by Abhishek Rawat on 07/10/20.
//  Copyright © 2020 Abe10. All rights reserved.
//

import SwiftUI

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.primary.opacity(0.5), lineWidth: 1))
    }
}

struct Signin: View {
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
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
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 10)
                SecureField("Password", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.bottom, 10)
                ZStack {
                    Color.green.frame(height: 50).cornerRadius(5)
                    Text("Log in").foregroundColor(.white).onTapGesture(perform: loginHandler)
                }
                .padding(.bottom, 10)
                HStack {
                    Spacer()
                    Text("Don't have an account?")
                    Button(action : {}) {
                        Text("Sign up").foregroundColor(.green)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
        }
    }
    
    func loginHandler() {
        print("I was pressed!!")
    }
}

struct Signin_Previews: PreviewProvider {
    static var previews: some View {
        Signin()
    }
}
