//
//  Preview.swift
//  Pokemon
//
//  Created by Matteo Manferdini on 28/05/24.
//

import Foundation

extension Pokemon {
	static let preview: Self = {
		let url = Bundle.main.url(forResource: "Bulbasaur", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		return try! JSONDecoder().decode(Pokemon.self, from: data)
	}()
}
