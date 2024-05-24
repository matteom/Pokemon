//
//  PokemonView.swift
//  Pokemon
//
//  Created by Matteo Manferdini on 24/05/24.
//

import SwiftUI

struct PokemonView: View {
	var body: some View {
		let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
		AsyncImage(url: url) { phase in
			if let image = phase.image {
				image.resizable()
			} else if phase.error != nil {
				ContentUnavailableView(label: {
					Image(systemName: "photo")
						.font(.title)
						.foregroundStyle(.secondary)
				}, actions: {
					Button(action: {}) {
						Label("Retry", systemImage: "arrow.counterclockwise")
					}
				})
			} else {
				ProgressView()
					.controlSize(.large)
			}
		}
		.frame(width: 200, height: 200)
	}
}

#Preview {
    PokemonView()
}
