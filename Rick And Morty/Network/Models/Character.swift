//
//  Character.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

import Fakery
import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let species: String
    let status: CharacterStatus

    static func mock(status: CharacterStatus = .alive) -> Character {
        let faker = Faker()
        return Character(
            id: faker.number.randomInt(),
            name: faker.name.name(),
            image: faker.internet.image(),
            species: "Human",
            status: status
        )
    }
}
