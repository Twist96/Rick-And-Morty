//
//  ContentView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

import SwiftUI

struct ContentView: View {
    var characterService: ICharacterService = CharacterService()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            CharacterView { character in
                path.append(character)
            }
            .navigationDestination(for: Character.self) { character in
                CharacterDetailsView(
                    viewModel: CharacterDetailsViewModel(character)
                )
            }
        }
    }
}

#Preview {
    ContentView(characterService: CharacterServiceDouble())
}
