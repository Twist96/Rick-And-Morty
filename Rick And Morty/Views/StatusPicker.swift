//
//  StatusPicker.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import SwiftUI

struct StatusPicker: View {
    @Binding var selectedStatus: CharacterStatus?
    let statusList = CharacterStatus.allCases

    var body: some View {
        HStack {
            ForEach(statusList) { status in
                Button{
                    if selectedStatus == status {
                        selectedStatus = nil
                    } else {
                        selectedStatus = status
                    }
                } label: {
                    Text(status.rawValue)
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background {
                            if status == selectedStatus {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.gray.opacity(0.35))
                            } else {
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.gray, lineWidth: 1)
                            }
                        }
                }
            }
        }
    }


}

#Preview {
    @Previewable @State var selectedStatus: CharacterStatus? = CharacterStatus.alive
    StatusPicker(selectedStatus: $selectedStatus)
}
