//
//  CharacterView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModel = CharacterListViewModel()
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
            if viewModel.characters == nil {
                viewModel.resetCharacters()
            }
        }
    }
}

#Preview {
    CharacterListView(
        viewModel: CharacterListViewModel(
            characterService: CharacterServiceDouble()
        )
    )
}
