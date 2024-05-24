//
//  Pokemon.swift
//  Pokemon
//
//  Created by Matteo Manferdini on 28/05/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
	let id: Int
	let name: String
	let imageURL: URL
	var imageDataURL: URL?

	enum CodingKeys: CodingKey {
		case id
		case name
		case sprites
	}

	enum SpritesCodingKeys: String, CodingKey {
		case other
	}

	enum OtherCodingKeys: String, CodingKey {
		case artwork = "official-artwork"
	}

	enum ArtworkCodingKeys: String, CodingKey {
		case front = "front_default"
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		let sprites = try container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
		let other = try sprites.nestedContainer(keyedBy: OtherCodingKeys.self, forKey: .other)
		let artwork = try other.nestedContainer(keyedBy: ArtworkCodingKeys.self, forKey: .artwork)
		imageURL = try artwork.decode(URL.self, forKey: .front)
	}
}
