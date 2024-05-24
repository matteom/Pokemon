//
//  ContentView.swift
//  Pokemon
//
//  Created by Matteo Manferdini on 24/05/24.
//

import SwiftUI

struct ContentView: View {
	@State private var viewModel = ViewModel()

    var body: some View {
		List(viewModel.pokemon) { pokemon in
			PokemonRow(pokemon: pokemon)
				.task { try? await viewModel.downloadImage(for: pokemon) }
		}
		.task { await refresh() }
		.refreshable {
			viewModel.pokemon = []
			await refresh()
		}
    }

	func refresh() async {
		try? await viewModel.fetchPokemonList()
	}
}

#Preview {
    ContentView()
}

@Observable class ViewModel {
	var pokemon: [Pokemon] = []
	private let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
	private let session = URLSession(configuration: .default)

	func fetchPokemonList() async throws {
		pokemon = try await withThrowingTaskGroup(of: Pokemon.self) { group in
			let (data, _) = try await URLSession.shared.data(from: url)
			let response = try JSONDecoder().decode(Response.self, from: data)
			for result in response.results {
				group.addTask {
					let (data, _) = try await URLSession.shared.data(from: result.url)
					return try JSONDecoder().decode(Pokemon.self, from: data)
				}
			}
			var results: [Pokemon] = []
			for try await pokemon in group {
				results.append(pokemon)
			}
			return results.sorted(using: KeyPathComparator(\.name))
		}
	}

	func downloadImage(for pokemon: Pokemon) async throws {
		guard let index = self.pokemon.firstIndex(where: { $0.id == pokemon.id }),
			  self.pokemon[index].imageDataURL == nil
		else { return }
		let (data, _) = try await session.data(from: pokemon.imageURL)
		let dataURL = URL(string: "data:image/png;base64," + data.base64EncodedString())
		self.pokemon[index].imageDataURL = dataURL
	}
}
