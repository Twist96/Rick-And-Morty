//
//  CharacterViewModel.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 04/12/2024.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character]?
    @Published var page = 0
    @Published var selectedStatus: CharacterStatus?
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private let characterService: ICharacterService
    private var fetchTask: Task<Void, Never>?

    init(characterService: ICharacterService = CharacterService()) {
        self.characterService = characterService
        setupStatusChangeHandling()
    }

    private func setupStatusChangeHandling() {
        let statusStream = AsyncStream { continuation in
            let cancellable = $selectedStatus.sink { status in
                continuation.yield(status)
            }

            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }

        Task { [weak self] in
            for await _ in statusStream {
                await self?.resetCharacters()
            }
        }
    }

    @MainActor
    func loadMore() {
        fetchTask?.cancel()

        fetchTask = Task {
            do {
                isLoading = true
                let characters = try await getCharacters()
                self.characters?.append(contentsOf: characters ?? [])
                isLoading = false
            } catch {
                self.error = error
            }
        }
    }

    @MainActor
    func resetCharacters(){
        fetchTask?.cancel()

        self.page = 0
        fetchTask = Task {
            do {
                isLoading = true
                let newCharacters = try await getCharacters()
                characters = newCharacters
                isLoading = false
            } catch {
                self.error = error
            }
        }
    }

    @MainActor
    func getCharacters() async throws -> [Character]? {
        let query = CharacterQuery(page: page + 1, status: selectedStatus)

        try Task.checkCancellation()

        let response = try await characterService.get(query: query)
        page = page + 1
        return response.results
    }

}
