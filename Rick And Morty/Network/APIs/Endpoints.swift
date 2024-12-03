//
//  Endpoints.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//
import Foundation

public enum RickAndMortyAPIs: String {
    case character = "/character"

    static let baseURL = URL(string: "https://rickandmortyapi.com/api")!
}
