//
//  UserListViewModel.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import Foundation

class UserListViewModel {
    var users: [User] = [] {
        didSet {
            onDataChange?()
        }
    }
    
    var onDataChange: (() -> Void)?
    
    let apiService = APIService()
    
    func fetchUsers() async {
        guard
            users.isEmpty
        else {
            return
        }
        do {
            let usersDTO = try await apiService.fetchUsers()
            self.users = usersDTO.map(User.init(from:))
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
