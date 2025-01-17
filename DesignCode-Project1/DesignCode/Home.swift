//
//  Home.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/11/21.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
        
            HomeBackgroundView()
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.3))
                .edgesIgnoringSafeArea(.all)
            
           // TabView {
                HomeView(showProfile: $showProfile, showContent: $showContent, viewState: .constant(.zero))
//                    .tabItem {
//                        Image(systemName: "play.circle.fill")
//                        Text("Home")
//                    }
               // }
            
            
            MenuView(showProfile: $showProfile)
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration:0.3))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                    .onEnded { value in
                        if self.viewState.height > 50 {
                            self.showProfile = false
                        }
                        self.viewState = .zero
                    }
                )
            
            
            if user.showLogin{
                ZStack {
                    LoginView()
                    
                    VStack {
                        HStack {
                            
                            Spacer()
                            
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        self.user.showLogin = false
                    }
                }
            }
            
            if showContent {
                BlurView(style: .systemMaterial).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                ContentView()
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(UserStore())
    }
}
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    @EnvironmentObject var user: UserStore

    var body: some View {
        VStack {
            if user.isLogged {
                Button(action: { self.showProfile.toggle() }) {
                Image("Avatar")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                }
            } else {
                Button(action: { self.user.showLogin.toggle() }) {
                Image(systemName:"person")
                    .renderingMode(.original)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                }
            }
        }
    }
}

let screen = UIScreen.main.bounds
	

struct HomeBackgroundView: View {
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                .frame(height:200)
            Spacer()
        }
        .background(Color("background1"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
    }
}
