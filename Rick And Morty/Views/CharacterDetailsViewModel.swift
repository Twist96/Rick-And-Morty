//
//  CharacterDetailsViewModel.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 04/12/2024.
//

import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    @Published var id: Int
    @Published var image: String
    @Published var name: String
    @Published var status: CharacterStatus
    @Published var species: String
    @Published var gender: String?
    @Published var location: String?

    let characterService: ICharacterService

    init(
        _ character: Character,
        characterService: ICharacterService = CharacterService()
    ) {
        id = character.id
        image = character.image
        name = character.name
        status = character.status
        species = character.species
        self.characterService = characterService
    }

    @MainActor
    func setCharacterDetails(id: Int) async {
        do {
            let character = try await characterService.get(
                id: String(describing: id))
            self.image = character.image
            self.name = character.name
            self.status = character.status
            self.species = character.species
            self.gender = character.gender
            self.location = character.location.name
        } catch {
            print(error)
        }
    }
}
