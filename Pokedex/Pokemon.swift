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
    let back_default: String
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct FlavorData: Codable {
    let flavor_text_entries: [FlavorTextEntry]
}

struct FlavorTextEntry: Codable {
    let flavor_text: String
    let language: PokemonLanguage
}

struct PokemonLanguage: Codable {
    let name: String
    let url: String
}
