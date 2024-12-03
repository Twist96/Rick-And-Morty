//
//  CharacterView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct CharacterView: View {
    @State var selectedStatus: CharacterStatus?
    @State var characters: [Character] = []
    @State var page = 0
    var characterService: ICharacterService = CharacterService()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Characters")
                .font(.title)

            StatusPicker(selectedStatus: $selectedStatus)

            TableView(items: characters, loadMore: loadMore) { character in
                CharacterItemView(character: character)
                    .padding(.bottom, 12)
            }
        }
        .padding(.horizontal, 16)
        .task {
            characters = await getCharacters() ?? []
        }
        .onChange(of: selectedStatus) { prev, current in
            page = 0
            Task {
                let characters = await getCharacters()
                self.characters = characters ?? []
            }
        }
    }

    func loadMore() {
        Task {
            let characters = await getCharacters()
            self.characters.append(contentsOf: characters ?? [])
        }
    }

    func getCharacters() async -> [Character]? {
        do {
            let query = CharacterQuery(page: page + 1, status: selectedStatus)
            let res = try await characterService.get(query: query)
            return res.results
        } catch {
            print(error)
            return nil
        }
    }
}

#Preview {
    CharacterView(characterService: CharacterServiceDouble())
}
