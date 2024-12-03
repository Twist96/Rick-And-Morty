//
//  CharacterView.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct CharacterView: View {
    @State var selectedStatus: CharacterStatus?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Characters")
                .font(.title)

            StatusPicker(selectedStatus: $selectedStatus)

            Spacer()
        }
    }
}

#Preview {
    CharacterView()
}
