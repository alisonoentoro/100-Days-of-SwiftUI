//
//  UserStore.swift
//  DesignCode
//
//  Created by Alison Oentoro on 2/1/21.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    
    @Published var showLogin = false
}
