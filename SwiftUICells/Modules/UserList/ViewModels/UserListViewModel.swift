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
            self.users = try await apiService.fetchUsers()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
