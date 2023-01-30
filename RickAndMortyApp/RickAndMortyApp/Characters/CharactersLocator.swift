//
//  CharactersLocator.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 30/1/23.
//

import Foundation

protocol CharactersServiceLocator {
    func service() -> CharactersService
    func storageService() -> CharactersStorageService
}

struct CharactersLocator: CharactersServiceLocator {
    func service() -> CharactersService {
        CharactersServiceAdapter(httpClient: httpClient())
    }
    
    func storageService() -> CharactersStorageService {
        CharactersStorageServiceAdapter(defaults: userDefaults())
    }
    
    private func httpClient() -> HttpClient {
        HttpClientProxy(urlSession: URLSession.shared)
    }
    
    private func userDefaults() -> UserDefaults {
        UserDefaults.standard
    }
}
