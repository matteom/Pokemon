//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Matteo Manferdini on 28/05/24.
//

import SwiftUI

struct PokemonRow: View {
	let pokemon: Pokemon

    var body: some View {
		LabeledContent {
			AsyncImage(url: pokemon.imageDataURL) { phase in
				if let image = phase.image {
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
				} else if phase.error != nil {
					Image(systemName: "photo")
						.font(.title)
						.foregroundStyle(.secondary)
				} else {
					ProgressView()
				}
			}
			.frame(width: 100)
		} label: {
			Text(pokemon.name.capitalized)
				.font(.title)
				.bold()
		}
    }
}

#Preview {
	List {
		PokemonRow(pokemon: .preview)
	}
}
