//
//  HTTPURLResponse+Init.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import Foundation

extension HTTPURLResponse {
    convenience init?(statusCode: Int) {
        guard let url = URL(string: "http") else {
            return nil
        }
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
