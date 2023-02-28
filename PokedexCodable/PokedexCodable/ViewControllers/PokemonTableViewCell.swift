//
//  PokemonTableViewCell.swift
//  PokedexCodable
//
//  Created by Jake Gloschat on 2/28/23.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
   
    // MARK: - Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonSpriteImageView.image = nil
        pokemonNameLabel.text = nil
        pokemonIdLabel.text = nil
    }
    
    
    func updateUI(forPokemon pokemon: PokemonResults) {
        NetworkingController.fetchPokemon(with: pokemon.url) { result in
            switch result {
            case .success(let pokemon):
                self.fetchSprite(forPokemon: pokemon)
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }
    
    func fetchSprite(forPokemon pokemon: Pokemon) {
        NetworkingController.fetchSprite(for: pokemon.sprites.frontShiny) { result in
            switch result {
            case .success(let sprite):
                DispatchQueue.main.async {
                    self.pokemonSpriteImageView.image = sprite
                    self.pokemonNameLabel.text = pokemon.name
                    self.pokemonIdLabel.text = "No: \(pokemon.id)"
                }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }
}
