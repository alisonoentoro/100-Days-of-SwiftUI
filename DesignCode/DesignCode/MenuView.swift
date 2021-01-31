//  MenuView.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/11/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing:16) {
                Text("Meng - 28% Complete")
                    .font(.caption)
                
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height:300)
            .background(BlurView(style: .systemMaterial))
            .clipShape (RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal,30)
            .overlay(
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .offset(y:-150)
            )
        }
        .padding(.bottom, 30)
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title:String
    var icon: String
    
    var body: some View {
        HStack (spacing:16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .imageScale(.large)
                .frame(width:32, height: 32)
            
            Text(title)
                .font(.system(size: 20, weight:.bold, design:.rounded))
                .frame(width:120, alignment: .leading)
        }
    }
}
