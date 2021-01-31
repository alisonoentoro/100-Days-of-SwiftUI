//
//  TabBar.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/13/21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
                
            }
            CourseList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("COurses")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
