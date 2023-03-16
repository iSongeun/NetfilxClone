// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieModel = try? JSONDecoder().decode(MovieModel.self, from: jsonData)

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let trackName : String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let releaseDate: String?
    let shortDescription: String?
    let longDescription: String?

    enum CodingKeys: String, CodingKey {
        case trackName
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100
        case releaseDate, shortDescription, longDescription
    }
}

