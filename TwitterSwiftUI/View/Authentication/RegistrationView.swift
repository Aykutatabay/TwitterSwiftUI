//
//  RegistrationView.swift
//  TwitterSwiftUI
//
//  Created by Aykut ATABAY on 16.01.2023.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var fullName: String = ""
    @State var userName: String = ""
    @State private var showImagePicker: Bool = false
    @State var selectedImage: PhotosPickerItem? = nil
    @State var realImageData: Data? = nil
    @EnvironmentObject var viewModel: AuthViewModel
//    @State var selectedImageUI: UIImage?
//    @State var image: Image?
    
    @Environment(\.presentationMode) var presentationMode
    
    /*
     func loadImage() {
         guard let selectedImage = selectedImageUI else {
             return
         }
         self.image = Image(uiImage: selectedImage)
     }
     */
    
    

     

    var body: some View {
        ZStack {
            Color.twitter.twitter
                .ignoresSafeArea()
            

            
            
            VStack {
                
                // MARK UIKit Image Picker
                /*
                 Button {
                     showImagePicker.toggle()
                 } label: {
                     ZStack {
                         
                         if let image = self.image {
                             
                             image
                                 .resizable()
                                 .scaledToFill()
                                 .frame(width: 140, height: 140)
                                 .clipShape(Circle())
                                 .padding(.top, 50)
                                 
                         } else {
                             Image("plus_photo")
                                 .resizable()
                                 .renderingMode(.template)
                                 .foregroundColor(.white)
                                 .scaledToFill()
                                 .frame(width: 140, height: 140)
                                 .padding(.top, 50)
                         }

                     }
                 }.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                     ImagePicker(image: $selectedImageUI)
                 }
                 */
                

                
                
                // MARK SwiftUI Image Picker
                PhotosPicker(selection: $selectedImage) {
                    ZStack {
                        if let realImageData,
                           let uiImage = UIImage(data: realImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .padding(.top, 50)
                        } else {
                            Image("plus_photo")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .padding(.top, 50)
                        }
                    }

                        
                }.onChange(of: selectedImage) { newValue in
                    Task {
                        do {
                            let data = try await newValue?.loadTransferable(type: Data.self)
                            realImageData = data
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }

                VStack(spacing: 20) {
                    CustomTextField(text: $fullName, placeholder: Text("Full Name"), imageName: "person")
                        .padding()
                        .frame(width: 345, height: 55)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .frame(width: 345, height: 55)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    CustomTextField(text: $userName, placeholder: Text("User Name"), imageName: "person")
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
                
                Button {
                    if let imageData = realImageData,
                    let image = UIImage(data: imageData) {
                        
                        viewModel.registerUser(email: email, password: password, username: userName, fullname: fullName, profileImage: image )
                    } else {
                        
                    }
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 360, height: 50)
                        .background()
                        .clipShape(Capsule())
                }
                .padding(.top, 15)
                
                Spacer()
                
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                        .font(.footnote)
                    
                    Text("Sing in")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 60)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
