//
//  ContentView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

import SwiftUI

struct ContentView: View {
    var characterService: ICharacterService = CharacterService()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let query = CharacterQuery(page: 2, status: nil)
                let characters = try await characterService.get(query: query)
                print(characters)
                let character = try await characterService.get(id: "1")
                print(character)
            } catch {
                print(error)
            }

        }
    }
}

#Preview {
    ContentView(characterService: CharacterServiceDouble())
}
