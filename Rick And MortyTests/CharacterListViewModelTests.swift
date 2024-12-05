//
//  CharacterListViewModelTests.swift
//  Rick And MortyTests
//
//  Created by Matthew Chukwuemeka on 05/12/2024.
//

import Testing
import XCTest
@testable import Rick_And_Morty

struct CharacterListViewModelTests {
    var viewModel = CharacterListViewModel()
    var characterService: CharacterServiceDouble = CharacterServiceDouble()

    @Test func testInitialState() async throws {
        XCTAssertNil(viewModel.characters)
        XCTAssertEqual(viewModel.page, 0)
        XCTAssertNil(viewModel.selectedStatus)
    }

    @Test mutating func testLoadMoreCharacters() async throws {
        let mockCharacters = Character.mocks(count: 6)
        characterService.mockCharacters = mockCharacters

        XCTAssertEqual(viewModel.page, 0)

        await viewModel.loadMore()

        XCTAssertEqual(viewModel.characters?.count, 6)
        XCTAssertEqual(viewModel.page, 1)
    }

    @Test mutating func testGetCharactersError() async {
        characterService.shouldThrowError = true

        let character = try? await viewModel.getCharacters()

        XCTAssertNil(character)
    }

}
