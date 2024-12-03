//
//  CharacterDetails.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

struct CharacterDetails: Codable {
    let id: Int
    let name: String
    let image: String
    let species: String
    let status: CharacterStatus
    let gender: String

    static func mock() -> CharacterDetails {
        return .init(
            id: 1,
            name: "Rick Sanchez",
            image: "rick",
            species: "Human",
            status: .alive,
            gender: "Male"
        )
    }
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
