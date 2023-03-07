//
//  LoginView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 16.01.2023.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.twitter.twitter
                    .ignoresSafeArea()
                
                VStack {
                    Image("TwitterLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 100)
                        .padding(.top, 50)
                    
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .frame(width: 345, height: 55)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                        
                        CustomSecureField(text: $password, placeholder: Text("Password"), imageName: "lock")
                            .padding()
                            .frame(width: 345, height: 55)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.top, 25)
                    
                    
                    HStack {
                        Spacer()
                        Text("Forgot Password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.trailing, 25)
                    }
                    .padding(.top, 15)
                    
                    Button {
                        viewModel.logIn(withEmail: email, password: password)
                    } label: {
                        Text("Sign in")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 360, height: 50)
                            .background()
                            .clipShape(Capsule())
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView().navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                                .font(.footnote)
                            Text("Sing Up")
                                .foregroundColor(.white)
                                .font(.footnote)
                                .fontWeight(.bold)

                        }
                        .padding(.horizontal, 60)
                    }

                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
