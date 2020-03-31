//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jan Lewandowski on 29/03/2020.
//  Copyright © 2020 janlewandowski. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonData: Codable {
    let id: Int
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprites
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

struct PokemonSprites: Codable {
    let front_default: String
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}
