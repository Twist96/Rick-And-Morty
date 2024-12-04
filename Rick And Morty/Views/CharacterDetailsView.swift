//
//  CharacterDetailsView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    @ObservedObject var viewModel: CharacterDetailsViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: viewModel.image)) { image in
                    image
                        .resizable()
                        .frame(height: 350)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(30)
                } placeholder: {
                    Image(systemName: "person")
                        .resizable()
                        .frame(height: 350)
                        .aspectRatio(contentMode: .fill)
                        .background(Color.gray)
                        .cornerRadius(24)
                }

                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.name)
                            .font(.title)
                        Spacer()
                        Text(viewModel.status.rawValue)
                            .font(.subheadline)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background {
                                background(status: viewModel.status)
                            }
                    }

                    Text("\(viewModel.species) . \(viewModel.gender ?? "")")
                        .redacted(
                            reason: viewModel.gender == nil ? .placeholder : [])
                    HStack {
                        Text("Location:")
                        Text(viewModel.location ?? "")
                    }
                    .redacted(
                        reason: viewModel.location == nil ? .placeholder : []
                    )
                    .padding(.top, 12)
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .overlay {
            Image(systemName: "arrow.backward")
                .frame(width: 50, height: 50)
                .background {
                    Color.white
                        .clipShape(Circle())
                }
                .onTapGesture {
                    dismiss()
                }
                .position(x: 42, y: 16)
        }
        .task {
            await viewModel.setCharacterDetails(id: viewModel.id)
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
    CharacterDetailsView(
        viewModel: CharacterDetailsViewModel(
            Character.mock(),
            characterService: CharacterServiceDouble()
        )
    )
}
