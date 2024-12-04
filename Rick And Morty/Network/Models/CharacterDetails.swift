//
//  CharacterDetails.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

import Fakery

struct CharacterDetails: Codable {
    let id: Int
    let name: String
    let image: String
    let species: String
    let status: CharacterStatus
    let gender: String
    let location: Location

    static func mock() -> CharacterDetails {
        let faker = Faker()
        return .init(
            id: faker.number.randomInt(),
            name: faker.name.name(),
            image: faker.internet.image(),
            species: "Human",
            status: .alive,
            gender: faker.gender.binaryType(),
            location: .mock()
        )
    }
}

struct Location: Codable {
    let name: String
    let url: String

    static func mock() -> Location {
        let faker = Faker()
        return .init(
            name: faker.address.city(),
            url: faker.internet.url()
        )
    }
}

enum CharacterStatus: String, CaseIterable, Codable, Identifiable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

    var id: String {
        self.rawValue
    }
}
