//
//  CharacterQuery.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 03/12/2024.
//

import Foundation

struct CharacterQuery: Hashable {
    let page: Int
    let status: CharacterStatus?
}

extension CharacterQuery {

    func queryItems() -> [URLQueryItem] {
        let mirror = Mirror(reflecting: self)
        var queryItems: [URLQueryItem] = []

        for child in mirror.children {
            if let label = child.label {
                switch child.value {
                case Optional<Any>.none:
                    continue
                case Optional<Any>.some(let x):
                    queryItems.append(URLQueryItem(
                        name: label,
                        value: String(describing: x)
                    ))
                default:
                    continue
                }
            }
        }
        return queryItems
    }
}
