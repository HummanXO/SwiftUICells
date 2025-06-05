//
//  APIService.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalideResponse
    case invalideStatusCode
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalideResponse:
            "Invalide response"
        case .invalideStatusCode:
            "Invalide status code"
        case .decodingFailed:
            "Decoding failed"
        }
    }
}

struct APIService {
    let baseURL = "http://localhost:3000/users"
    
    func fetchUsers() async throws -> [UserDTO] {
        guard
            let url = URL(string: baseURL)
        else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw APIError.invalideStatusCode
            }
            
//            guard
//                let data = data as? Data
//            else {
//                throw APIError.invalideResponse
//            }
            
            do {
                return try JSONDecoder().decode([UserDTO].self, from: data)
            }
            catch {
                throw APIError.decodingFailed
            }
        }
    }
}
