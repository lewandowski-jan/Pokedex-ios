//
//  ViewController.swift
//  Pokedex
//
//  Created by Jan Lewandowski on 29/03/2020.
//  Copyright © 2020 janlewandowski. All rights reserved.
//

import UIKit

class ViewController: UITableViewController ,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    var pokemon: [Pokemon] = []
    var currentPokemon: [Pokemon] = []
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        
        guard let u = url else {
            return
        }
    
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                self.pokemon = pokemonList.results
                self.currentPokemon = self.pokemon
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = capitalize(text: currentPokemon[indexPath.row].name)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSegue" {
            if let destination = segue.destination as? PokemonViewController {
                destination.pokemon = currentPokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentPokemon = pokemon
            table.reloadData()
            return
        }
        currentPokemon = pokemon.filter({ Pokemon -> Bool in
            Pokemon.name.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
}
