//
//  CharactersServiceAdapterTests.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class CharactersServiceAdapterTests: XCTestCase {
    private var mockHttpClient: HttpClientMock!
    private var sut: CharactersServiceAdapter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockHttpClient = HttpClientMock()
        sut = CharactersServiceAdapter(httpClient: mockHttpClient)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockHttpClient = nil
        sut = nil
    }

    func testWrongPage() async throws {
        do {
            _ = try await sut.getCharacters(page: 0)
            
            XCTFail("sut.getCharacters(page: 0) should fail for page 0")
        } catch let CharactersServiceError.internalError(url)  {
            XCTAssertEqual(url, "https://rickandmortyapi.com/api/character?page=0")
        }
    }
    
    func testWrongDecoding() async throws {
        do {
            mockHttpClient.response = (Data(), try XCTUnwrap(HTTPURLResponse(statusCode: 500)))
            
            _ = try await sut.getCharacters(page: 1)
            
            XCTFail("sut.getCharacters(page: 1) should fail for page 1")
        } catch DecodingError.dataCorrupted {
            XCTAssertEqual(mockHttpClient.timesInvoked, 1)
        }
    }
    
    func testSuccess() async throws {
        let jsonResponse = """
        {
            "info": {
                "count": 826,
                "pages": 42,
                "next": "https://rickandmortyapi.com/api/character?page=2",
                "prev": null
            },
            "results": [{
                "id": 1,
                "name": "Rick Sanchez",
                "status": "Alive",
                "species": "Human",
                "type": "",
                "gender": "Male",
                "origin": {
                    "name": "Earth (C-137)",
                    "url": "https://rickandmortyapi.com/api/location/1"
                },
                "location": {
                    "name": "Citadel of Ricks",
                    "url": "https://rickandmortyapi.com/api/location/3"
                },
                "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                "episode": ["https://rickandmortyapi.com/api/episode/1"],
                "url": "https://rickandmortyapi.com/api/character/1",
                "created": "2017-11-04T18:48:46.250Z"
            }]
        }
        """
        mockHttpClient.response = (Data(jsonResponse.utf8), try XCTUnwrap(HTTPURLResponse(statusCode: 200)))
        
        let output = try await sut.getCharacters(page: 1)
        
        let expectedPage = Page(pages: 42)
        XCTAssertEqual(output.page, expectedPage)
        XCTAssertEqual(output.characters.count, 1)
        let expectedCharacter = Character(id: 1, image: try XCTUnwrap(URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")), name: "Rick Sanchez", status: .alive)
        XCTAssertEqual(output.characters.first, expectedCharacter)
    }
}
