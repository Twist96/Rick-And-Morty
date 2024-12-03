//
//  Character.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
    let species: String

    static func mock() -> Character {
        Character(
            id: 1,
            name: "Rick Sanchez",
            image: "rick",
            species: "Human"
        )
    }
}
