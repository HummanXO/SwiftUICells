//
//  User.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import Foundation

class User: ObservableObject {
    @Published var id: Int = 0
    @Published var name: String
    @Published var age: Int
    @Published var isPremium: Bool
    
    init(id: Int, name: String, age: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.age = age
        self.isPremium = isPremium
    }
    
    init(from dto: UserDTO) {
        self.id = dto.id
        self.name = dto.name
        self.age = dto.age
        self.isPremium = dto.isPremium
    }
}
