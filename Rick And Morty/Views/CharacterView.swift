//
//  CharacterView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var viewModel: CharacterViewModel = CharacterViewModel()
    var onSelect: ((Character) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Characters")
                .font(.title)

            StatusPicker(selectedStatus: $viewModel.selectedStatus)

            TableView(
                items: viewModel.characters ?? [],
                loadMore: viewModel.loadMore
            ) { character in
                CharacterItemView(character: character)
                    .padding(.bottom, 12)
                    .onTapGesture {
                        onSelect?(character)
                    }
            }
        }
        .padding(.horizontal, 16)
        .task {
            if viewModel.page == 0 {
                viewModel.characters = await viewModel.getCharacters() ?? []
            }
        }
    }
}

#Preview {
    CharacterView(
        viewModel: CharacterViewModel(
            characterService: CharacterServiceDouble()
        )
    )
}


import Combine
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character]?
    @Published var page = 0
    @Published var selectedStatus: CharacterStatus?
    let characterService: ICharacterService

    private var cancellables: Set<AnyCancellable> = []

    init(characterService: ICharacterService = CharacterService()) {
        self.characterService = characterService

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

//    @MainActor
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
            page = page + 1
            let query = CharacterQuery(page: page, status: selectedStatus)
            let res = try await characterService.get(query: query)
            return res.results
        } catch {
            print(error)
            return nil
        }
    }

}
