//
//  ButtonsExample.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/27/21.
//

import SwiftUI

struct ButtonsExample: View {
    
    var body: some View {
        VStack (spacing:50){
            RectangleButton()
            
            CircleButton()
            
            PayButton()
            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response:0.5, dampingFraction: 0.5, blendDuration: 0))
    }

}

struct ButtonsExample_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsExample()
    }
}
       

struct RectangleButton: View {
    @State var tap = false
    @State var press = false
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                ZStack {
                    Color(press ? (#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : (#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(Color(press ? #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 4)
                        .offset(x: -8, y:-8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(Color.white.opacity(press ? 0:1))
                        .frame(width: press ? 64 : 54, height: press ? 4: 50)
                        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius:16, style: .continuous))
                        .shadow(color:Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                        .offset(x:  press ? 70 : -10, y: press ? 16 : 0)
                        .animation(.easeIn)
                    
                    Spacer()
                }
            )
            .shadow(color: press ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .shadow(color: press ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(tap ? 1.2 :1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged { value in
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        self.tap = false
                    }
                }
                .onEnded { value in
                    self.press.toggle()
                    
                }
            )
    }
}

struct CircleButton: View {
    @State var tap = false
    @State var press = false
    var body: some View {
        ZStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? -90 : 0, y: press ? -90 : 0)
                .rotation3DEffect(Angle(degrees: press ? 20 : 0 ), axis: (x: 10, y: -10, z: 0))
            
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? 0 : 90, y: press ? 0 :90)
                .rotation3DEffect(Angle(degrees: press ? 0 : 20 ), axis: (x: -10, y: 10, z: 0))
        }
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.8527316973, green: 0.8652214805, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(press ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0): #colorLiteral(red: 0.8527316973, green: 0.8652214805, blue: 0.8941176471, alpha: 1) )]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ? #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: -5, y: -5 )
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0): #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 3, x: 3, y: 3)
            }
        )
        .clipShape(Circle())
        .shadow(color: Color(press ? #colorLiteral(red: 0.7678303011, green: 0.7843137255, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        .shadow(color: Color(press ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0): #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture().onChanged{ value in
                self.tap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.tap = false
                }
            }
            .onEnded { value in
                self.press.toggle()
            }
        )
    }
}

struct PayButton: View {
    @GestureState var tap = false
    @State var press = false
    var body: some View {
        ZStack {
            Image("fingerprint")
                .opacity(press ? 0: 1)
                .scaleEffect(press ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(Rectangle().offset(y: tap ? 0:50))
                .animation(.easeInOut)
                .scaleEffect(press ? 0 : 1)

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .opacity(press ? 1 : 0)
                .scaleEffect(press ? 1 : 0)

               
        }
        .frame(width: 120, height: 120)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.8527316973, green: 0.8652214805, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(press ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0): #colorLiteral(red: 0.8527316973, green: 0.8652214805, blue: 0.8941176471, alpha: 1) )]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ? #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: -5, y: -5 )
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0): #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 3, x: 3, y: 3)
            }
        )
        .clipShape(Circle())
        .overlay(
        Circle()
            .trim(from: tap ? 0.01 : 1, to: 1)
            .stroke(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),style: StrokeStyle(lineWidth: 5, lineCap: .round))
            .frame(width: 88, height: 88)
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(
                Angle(degrees: 180),
                axis: (x: 1, y: 0, z: 0))
            .animation(.easeInOut)
        )
        .shadow(color: Color(press ? #colorLiteral(red: 0.7678303011, green: 0.7843137255, blue: 0.8941176471, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        .shadow(color: Color(press ?  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0): #colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture().updating($tap){ currentState, gestureState, transaction in
                gestureState = currentState
                }
            .onEnded { value in
                self.press.toggle()
            }
        )
    }
}
