//
//  Character.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

import Foundation

protocol ICharacterService {
    func get(query: CharacterQuery?) async throws -> ApiListResult<[Character]>
    func get(id: String) async throws -> CharacterDetails
}

struct CharacterService: ICharacterService {
    func get(id: String) async throws -> CharacterDetails {
        return try await URLSession.shared.request(path: .character, id: id, httpMethod: .get)
    }
    
    func get(query: CharacterQuery?) async throws -> ApiListResult<[Character]> {
        return try await URLSession.shared.request(
            path: .character,
            httpMethod: .get,
            queryItems: query?.queryItems() ?? []
        )
    }
}

struct CharacterServiceDouble: ICharacterService {
    var mockCharacterDetails: CharacterDetails?
    var mockCharacters: [Character]?
    var shouldThrowError: Bool = false

    func get(id: String) async throws -> CharacterDetails {
        if shouldThrowError {
            throw NSError(domain: "Mock Error", code: -1)
        }
        return mockCharacterDetails ?? CharacterDetails.mock()
    }
    
    func get(query: CharacterQuery?) async throws -> ApiListResult<[Character]> {
        if shouldThrowError {
            throw NSError(domain: "Mock Error", code: -1)
        }
        return .mock(value: Character.mocks())
    }
}
