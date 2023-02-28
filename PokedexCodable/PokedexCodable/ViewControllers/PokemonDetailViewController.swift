//
//  PokemonDetailViewController.swift
//  PokedexCodable
//
//  Created by Jake Gloschat on 2/28/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.dataSource = self
        pokemonMovesTableView.delegate = self
    }
    
    // MARK: - Properties
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let pokemon = pokemon else { return }
        NetworkingController.fetchSprite(for: pokemon.sprites.frontShiny) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonNameLabel.text = pokemon.name.capitalized
                    self.pokemonIdLabel.text = "\(pokemon.id)"
                    self.pokemonSpriteImageView.image = image
                    self.pokemonMovesTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }
    
}

extension PokemonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        let move = pokemon?.moves[indexPath.row].move
        var config = cell.defaultContentConfiguration()
        config.text = move?.name.capitalized
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "moves"
    }
}
