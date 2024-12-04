//
//  CharacterViewModel.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 04/12/2024.
//

import Combine
import Foundation

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character]?
    @Published var page = 0
    @Published var selectedStatus: CharacterStatus?
    let characterService: ICharacterService

    private var cancellables: Set<AnyCancellable> = []

    init(characterService: ICharacterService = CharacterService()) {
        self.characterService = characterService

        //listen for change to selectedStatus
        $selectedStatus.sink { characterStatus in
            self.setCharacters()
        }.store(in: &cancellables)
    }

    @MainActor
    func loadMore() {
        Task {
            let characters = await getCharacters()
            self.characters?.append(contentsOf: characters ?? [])
        }
    }

    func setCharacters(){
        self.page = 0
        Task {
            let characters = await getCharacters()
            DispatchQueue.main.async {
                self.characters = characters ?? []
            }
        }
    }

    @MainActor
    func getCharacters() async -> [Character]? {
        do {
            let query = CharacterQuery(page: page + 1, status: selectedStatus)
            let res = try await characterService.get(query: query)
            page = page + 1
            return res.results
        } catch {
            print(error)
            return nil
        }
    }

}
