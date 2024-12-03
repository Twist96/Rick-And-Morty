//
//  CharacterView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct CharacterItemView: View {
    var character: Character
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(character.species)
                    .opacity(0.8)
                Spacer()
            }
            .padding(.top, 4)

            Spacer()
        }
        .padding()
        .frame(height: 108)
        .background(alignment: .center) {
            background(status: character.status)
        }
    }


    @ViewBuilder
    func background(status: CharacterStatus) -> some View {
        switch status {
        case .alive:
            Color("alive")
                .cornerRadius(12)
        case .dead:
            Color("dead")
                .opacity(0.5)
                .cornerRadius(12)

        case .unknown:
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

#Preview {
    VStack {
        CharacterItemView(character: .mock(status: .alive))
        CharacterItemView(character: .mock(status: .dead))
        CharacterItemView(character: .mock(status: .unknown))
    }
    .padding(.horizontal)
}
