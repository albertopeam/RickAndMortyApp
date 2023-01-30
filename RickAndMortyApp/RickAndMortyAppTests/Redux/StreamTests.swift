//
//  StreamTests.swift
//  RickAndMortyAppTests
//
//  Created by albertopeam on 2/2/23.
//

import XCTest
@testable import RickAndMortyApp

typealias Stream = RickAndMortyApp.Stream

final class StreamTests: XCTestCase {
    func testEmptyStream() async throws {
        let sut = Stream<TestState>()

        let result = await sut.values()

        XCTAssertEqual(result, [])
    }

    func testSingleStream() async throws {
        let sut = Stream<TestState>(item: { TestState(count: 2) })

        let result = await sut.values()

        XCTAssertEqual(result, [TestState(count: 2)])
    }

    func testMultiStream() async throws {
        let sut = Stream<TestState>(items: [{ TestState(count: 1) }, { TestState(count: 2) }])

        let result = await sut.values()

        XCTAssertEqual(result, [TestState(count: 1), TestState(count: 2)])
    }

    func testCancelTaskNotProcudeValues() async throws {
        let task = Task<[TestState], Never> {
            let sut = Stream<TestState>(item: { TestState(count: 1) })

            return await sut.values()
        }
        task.cancel()
        let result = await task.value
        XCTAssertEqual(result, [])
    }
}
