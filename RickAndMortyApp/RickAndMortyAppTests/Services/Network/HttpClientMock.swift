//
//  HttpClientMock.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import Foundation
@testable import RickAndMortyApp

final class HttpClientMock: HttpClient {
    var response: (Data, URLResponse) = (Data(), URLResponse())
    var timesInvoked: Int = 0
    
    func data(for url: URL) async throws -> (Data, URLResponse) {
        timesInvoked += 1
        return response
    }
}
