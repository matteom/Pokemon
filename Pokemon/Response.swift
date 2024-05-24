//
//  Response.swift
//  Pokemon
//
//  Created by Matteo Manferdini on 28/05/24.
//

import Foundation

struct Response: Decodable {
	let results: [Entry]
}

struct Entry: Decodable {
	let url: URL
}
