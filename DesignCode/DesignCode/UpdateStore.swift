//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Alison Oentoro on 1/13/21.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
