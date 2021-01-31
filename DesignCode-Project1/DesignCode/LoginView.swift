//
//  LoginView.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/29/21.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var showMessage = "Something went wrong"
    @State var isLoading = false
    @State var isSuccessful = false

    func login(){
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
    
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false

            
            if error != nil {
                self.showMessage = error?.localizedDescription ?? ""
                self.showAlert = true

            } else {
                self.isSuccessful = true
                
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.isSuccessful = false
                self.email = ""
                self.password = ""
                }
            }
        }
    }
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ZStack (alignment:.top){
                
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style:.continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.8227134651, green: 0.8395441229, blue: 1, alpha: 1)))
                            .frame(width:44, height:44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style:    .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(),text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .onTapGesture {
                                self.isFocused = true
                            }
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                    }
                    Divider()
                        .padding(.leading, 80)
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.8227134651, green: 0.8395441229, blue: 1, alpha: 1)))
                            .frame(width:44, height:44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style:    .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                            .padding(.leading)
                        
                        TextField("Password".uppercased(),text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .onTapGesture {
                                self.isFocused = true
                            }
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                        
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemChromeMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y:460)
                
                HStack {
                    Text("Forget Password")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Button(action: {
                        self.login()
                    }) {
                        Text("Log in")
                            .foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style:.continuous))
                    .shadow(color: (Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(self.showMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
            .offset(y: isFocused ? -300 : 0)
            .animation(isFocused ? .easeInOut : nil)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            if isLoading {
                LoadingView()
            }
            if isSuccessful {
                SuccessView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    @State var show = false
    @State var ViewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn design & code.\nFrom scratch.")
                    .font(.system(size: geometry.size.width/10, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.top, 100)
            .padding(.horizontal, 16)
            .offset(x: ViewState.width/15, y:ViewState.height/15)
            
            Text("80 hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .offset(x: ViewState.width/20, y:ViewState.height/20)
            
            
            Spacer()
        }
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x:-150, y:-200)
                   // .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration:120).repeatForever(autoreverses: false))
                    .onAppear{self.show = true}
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x:-200, y:-250)
                 //   .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                    .blendMode(.overlay)
                
                
                
            })
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3"))
                .offset(x: ViewState.width/25, y:ViewState.height/25)
            ,alignment: .bottom
        )
        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: ViewState.width, y: ViewState.height, z: 0))
        .gesture(
            DragGesture().onChanged{ value in
                self.ViewState = value.translation
                self.isDragging = true
            }
            .onEnded{ value in
                self.ViewState = .zero
                self.isDragging = false
            }
        )
    }
}
