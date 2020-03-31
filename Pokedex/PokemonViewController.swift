//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Jan Lewandowski on 30/03/2020.
//  Copyright © 2020 janlewandowski. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var pokemon: Pokemon!
    
    let backgroundImageView = UIImageView()
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    func setImage(from url: String) {
        self.imageView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.borderWidth = 4
        self.imageView.layer.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
        guard let imageURL = URL(string: url) else {return}
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        type1Label.text = ""
        type2Label.text = ""
        
        let url = URL(string: pokemon.url)
        
        guard let u = url else {
            return
        }
    
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = self.capitalize(text: self.pokemon.name)
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = self.capitalize(text: typeEntry.type.name)
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = self.capitalize(text: typeEntry.type.name)
                        }
                    }
                    
                    self.setImage(from: pokemonData.sprites.front_default)
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
    }
}
