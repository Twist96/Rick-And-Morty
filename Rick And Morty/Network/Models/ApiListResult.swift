//
//  APIResult.swift
//  Rick And Morty
//
//  Created by Matthew Chukwuemeka on 02/12/2024.
//

struct ApiListResult<T>: Codable where T : Codable & Collection {
    let info: APIInfo
    let results: T

    static func mock(value: T) -> ApiListResult<T> {
        .init(info: .mock(count: value.count), results: value)
    }
}

struct APIInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?

    static func mock(count: Int) -> APIInfo {
        .init(count: count, pages: 1, next: "", prev: "")
    }
}
